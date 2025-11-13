import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../config/odoo_config.dart';
import 'odoo_rpc_service.dart';

class FaceAttendanceService {
  static FaceAttendanceService? _instance;
  static FaceAttendanceService get instance =>
      _instance ??= FaceAttendanceService._internal();

  FaceAttendanceService._internal();

  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isCameraActive = false;
  bool? _geoFieldsSupported;

  // Getter for camera initialization status
  bool get isInitialized => _isInitialized;
  bool get isCameraActive => _isCameraActive;

  /// Initialize camera and permissions
  Future<bool> initializeCamera() async {
    try {
      // Request camera permission
      final cameraStatus = await Permission.camera.request();
      if (cameraStatus != PermissionStatus.granted) {
        print('❌ Camera permission denied');
        return false;
      }

      // Request location permission
      final locationStatus = await Permission.location.request();
      if (locationStatus != PermissionStatus.granted) {
        print('❌ Location permission denied');
        return false;
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        print('❌ No cameras available');
        return false;
      }

      // Initialize camera controller with front camera if available
      final frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isInitialized = true;

      print('✅ Camera initialized successfully');
      return true;
    } catch (e) {
      print('❌ Error initializing camera: $e');
      return false;
    }
  }

  /// Start camera preview
  Future<void> startCamera() async {
    if (_isInitialized && _cameraController != null) {
      try {
        await _cameraController!.resumePreview();
        _isCameraActive = true;
        print('✅ Camera started');
      } catch (e) {
        print('❌ Error starting camera: $e');
      }
    }
  }

  /// Stop camera preview
  Future<void> stopCamera() async {
    if (_cameraController != null) {
      try {
        await _cameraController!.pausePreview();
        _isCameraActive = false;
        print('✅ Camera stopped');
      } catch (e) {
        print('❌ Error stopping camera: $e');
      }
    }
  }

  /// Get camera controller
  CameraController? get cameraController => _cameraController;

  /// Get available cameras
  List<CameraDescription>? get cameras => _cameras;

  /// Take a photo and get current location
  Future<Map<String, dynamic>> takeAttendancePhoto() async {
    try {
      if (!_isInitialized || _cameraController == null) {
        return {'success': false, 'error': 'Camera not initialized'};
      }

      if (!_isCameraActive) {
        await startCamera();
      }

      // Get current location
      final location = await _getCurrentLocation();
      if (location == null) {
        return {'success': false, 'error': 'Could not get current location'};
      }

      // Take photo
      final image = await _cameraController!.takePicture();

      // Compress and convert image to base64
      final compressedBytes = await _compressImage(image.path);
      if (compressedBytes == null) {
        return {'success': false, 'error': 'Failed to compress image'};
      }
      final base64Image = base64Encode(compressedBytes);
      log('base64Image length: ${base64Image.length} characters');

      // Get address from coordinates
      final address = await _getAddressFromCoordinates(
        location.latitude,
        location.longitude,
      );

      final result = {
        'success': true,
        'image': base64Image,
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address': address,
        'timestamp': DateTime.now().toIso8601String(),
      };
      log('result takeAttendancePhoto: $result');
      return result;
    } catch (e, stackTrace) {
      log('❌ Error taking attendance photo: $e');
      log('❌ Stack trace: $stackTrace');
      return {'success': false, 'error': 'Error taking photo: $e'};
    }
  }

  /// Get current location
  Future<Position?> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('❌ Location services are disabled');
        return null;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('❌ Location permissions are permanently denied');
        return null;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      print('✅ Location obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('❌ Error getting location: $e');
      return null;
    }
  }

  /// Get address from coordinates
  Future<String> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final street = placemark.street?.trim();
        final locality = placemark.locality?.trim();
        final adminArea = placemark.administrativeArea?.trim();

        final parts = [
          if (street != null && street.isNotEmpty) street,
          if (locality != null && locality.isNotEmpty) locality,
          if (adminArea != null && adminArea.isNotEmpty) adminArea,
        ];

        if (parts.isNotEmpty) {
          return parts.join(', ');
        }
      }
      return 'Unknown location';
    } catch (e) {
      print('❌ Error getting address: $e');
      return 'Unknown location';
    }
  }

  /// Submit face attendance to Odoo with check-in/check-out logic
  Future<Map<String, dynamic>> submitFaceAttendance({
    required String base64Image,
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    try {
      if (!OdooRPCService.instance.isAuthenticated) {
        return {
          'success': false,
          'error': 'Not authenticated. Please login first.',
        };
      }

      // Check current attendance status
      final currentStatus = await getCurrentAttendanceStatus();
      final isCurrentlyCheckedIn = currentStatus['is_checked_in'] ?? false;
      final currentAttendanceId = currentStatus['attendance_id'];

      print(
        '🔍 Current attendance status: ${isCurrentlyCheckedIn ? "Checked In" : "Checked Out"}',
      );

      if (isCurrentlyCheckedIn) {
        // Perform check-out
        return await performCheckOut(
          attendanceId: currentAttendanceId,
          latitude: latitude,
          longitude: longitude,
          address: address,
        );
      } else {
        // Perform check-in
        return await performCheckIn(
          base64Image: base64Image,
          latitude: latitude,
          longitude: longitude,
          address: address,
        );
      }
    } catch (e) {
      print('❌ Error submitting face attendance: $e');
      return {'success': false, 'error': 'Error submitting attendance: $e'};
    }
  }

  /// Get current attendance status
  Future<Map<String, dynamic>> getCurrentAttendanceStatus() async {
    try {
      final result = await _callOdooMethod('hr.attendance', 'search_read', [
        [
          ['employee_id', '=', OdooRPCService.instance.currentEmployeeId],
          ['check_out', '=', false],
        ],
        ['id', 'check_in', 'check_out'],
      ]);

      if (result['success'] &&
          result['data'] != null &&
          result['data'].isNotEmpty) {
        final attendance = result['data'][0];
        return {
          'is_checked_in': true,
          'attendance_id': attendance['id'],
          'check_in': attendance['check_in'],
        };
      }

      return {'is_checked_in': false, 'attendance_id': null};
    } catch (e) {
      print('❌ Error getting current attendance status: $e');
      return {'is_checked_in': false, 'attendance_id': null};
    }
  }

  /// Perform check-in
  Future<Map<String, dynamic>> performCheckIn({
    required String base64Image,
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    try {
      final useGeo = _geoFieldsSupported ?? true;

      final attendanceData = <String, dynamic>{
        'employee_id': OdooRPCService.instance.currentEmployeeId,
        'check_in': _formatOdooDateTime(DateTime.now()),
      };

      if (useGeo) {
        attendanceData['in_latitude'] = latitude;
        attendanceData['in_longitude'] = longitude;
      }

      print('🔍 Performing check-in with data: $attendanceData');

      final result = await _callOdooMethod('hr.attendance', 'create', [
        attendanceData,
      ]);

      if (result['success']) {
        _geoFieldsSupported = useGeo;
        print('✅ Check-in successful');
        return {
          'success': true,
          'action': 'check_in',
          'message':
              'Successfully checked in with face recognition and location',
          'data': result['data'],
        };
      } else {
        final error = result['error']?.toString() ?? 'Failed to check in';
        if (useGeo && _looksLikeMissingGeoField(error)) {
          _geoFieldsSupported = false;
          return await performCheckIn(
            base64Image: base64Image,
            latitude: latitude,
            longitude: longitude,
            address: address,
          );
        }
        return {'success': false, 'action': 'check_in', 'error': error};
      }
    } catch (e) {
      return {
        'success': false,
        'action': 'check_in',
        'error': 'Exception during check-in: $e',
      };
    }
  }

  /// Perform check-out
  Future<Map<String, dynamic>> performCheckOut({
    required int attendanceId,
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    try {
      final useGeo = _geoFieldsSupported ?? true;

      final checkoutData = <String, dynamic>{
        'check_out': _formatOdooDateTime(DateTime.now()),
      };

      if (useGeo) {
        checkoutData['out_latitude'] = latitude;
        checkoutData['out_longitude'] = longitude;
      }

      print('🔍 Performing check-out with data: $checkoutData');

      final result = await _callOdooMethod('hr.attendance', 'write', [
        attendanceId,
        checkoutData,
      ]);

      if (result['success']) {
        _geoFieldsSupported = useGeo;
        print('✅ Check-out successful');
        return {
          'success': true,
          'action': 'check_out',
          'message': 'Successfully checked out with location data',
          'data': result['data'],
        };
      } else {
        final error = result['error']?.toString() ?? 'Failed to check out';
        if (useGeo && _looksLikeMissingGeoField(error)) {
          _geoFieldsSupported = false;
          return await performCheckOut(
            attendanceId: attendanceId,
            latitude: latitude,
            longitude: longitude,
            address: address,
          );
        }
        return {'success': false, 'action': 'check_out', 'error': error};
      }
    } catch (e) {
      return {
        'success': false,
        'action': 'check_out',
        'error': 'Exception during check-out: $e',
      };
    }
  }

  /// Call Odoo method
  Future<Map<String, dynamic>> _callOdooMethod(
    String model,
    String method,
    List<dynamic> args,
  ) async {
    try {
      final url = Uri.parse('${OdooConfig.baseUrl}/jsonrpc');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'HR App Flutter Face Attendance',
          'Accept': 'application/json',
        },
        body: json.encode({
          'jsonrpc': '2.0',
          'method': 'call',
          'params': {
            'service': 'object',
            'method': 'execute_kw',
            'args': [
              OdooRPCService.instance.currentDatabase,
              OdooRPCService.instance.currentUserId,
              OdooRPCService.instance.currentPassword,
              model,
              method,
              args,
            ],
          },
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['error'] != null) {
          return {
            'success': false,
            'error':
                jsonResponse['error']['data']['message'] ??
                'Odoo method call failed',
          };
        }

        return {'success': true, 'data': jsonResponse['result']};
      } else {
        return {
          'success': false,
          'error': 'HTTP Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'error': 'Exception: $e'};
    }
  }

  /// Format DateTime to Odoo expected UTC string without fractional seconds
  String _formatOdooDateTime(DateTime dateTime) {
    final utc = dateTime.toUtc();
    return '${utc.year.toString().padLeft(4, '0')}'
        '-${utc.month.toString().padLeft(2, '0')}'
        '-${utc.day.toString().padLeft(2, '0')} '
        '${utc.hour.toString().padLeft(2, '0')}:'
        '${utc.minute.toString().padLeft(2, '0')}:'
        '${utc.second.toString().padLeft(2, '0')}';
  }

  bool _looksLikeMissingGeoField(String message) {
    return message.contains("Invalid field 'in_latitude'") ||
        message.contains("Invalid field 'in_longitude'") ||
        message.contains("Invalid field 'out_latitude'") ||
        message.contains("Invalid field 'out_longitude'");
  }

  Future<Map<String, dynamic>> submitFaceViaController({
    required String base64Image,
    double? latitude,
    double? longitude,
  }) async {
    try {
      final url = Uri.parse('${OdooConfig.baseUrl}/submit_face');
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'User-Agent': 'HR App Flutter Face Attendance',
            },
            body: {
              'face_image': 'data:image/jpeg;base64,$base64Image',
              'latitude': latitude?.toString() ?? '',
              'longitude': longitude?.toString() ?? '',
            },
          )
          .timeout(Duration(milliseconds: OdooConfig.writeTimeout));

      if (response.statusCode == 200) {
        final message = _extractMessageFromHtml(response.body);
        final isSuccess = message.contains('Success') || message.contains('✅');
        return isSuccess
            ? {'success': true, 'message': message}
            : {'success': false, 'error': message};
      } else {
        return {'success': false, 'error': 'HTTP ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Face verification failed: $e'};
    }
  }

  String _extractMessageFromHtml(String html) {
    final messageMatch = RegExp(
      r'<p[^>]*class="message"[^>]*>(.*?)</p>',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(html);
    var message = messageMatch?.group(1) ?? html;
    message = message.replaceAll(RegExp(r'<[^>]+>'), '');
    message = message
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
    return message.trim();
  }

  /// Compress image to reduce size while maintaining quality for face recognition
  ///
  /// Compresses the image with 88% quality and resizes to max 1024x1024
  /// Returns compressed image bytes, or null if compression fails
  Future<List<int>?> _compressImage(String filePath) async {
    try {
      final result = await FlutterImageCompress.compressWithFile(
        filePath,
        minWidth: 1024,
        minHeight: 1024,
        quality: 88,
        format: CompressFormat.jpeg,
      );

      if (result != null) {
        final originalSize = File(filePath).lengthSync();
        final compressedSize = result.length;
        final reduction = ((originalSize - compressedSize) / originalSize * 100)
            .toStringAsFixed(1);
        log(
          '📸 Image compressed: ${originalSize ~/ 1024}KB → ${compressedSize ~/ 1024}KB (${reduction}% reduction)',
        );
      }

      return result;
    } catch (e) {
      log('❌ Error compressing image: $e');
      return null;
    }
  }

  /// Dispose camera resources
  void dispose() {
    _cameraController?.dispose();
    _isInitialized = false;
    _isCameraActive = false;
  }
}
