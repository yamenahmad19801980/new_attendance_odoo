import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../config/odoo_config.dart';
import '../services/face_attendance_service.dart';
import '../services/hr_service.dart';
import '../services/odoo_rpc_service.dart';
import 'login_screen.dart';
import 'odoo_config_screen.dart';

enum AttendanceAction { checkIn, checkOut }

class FaceAttendanceScreen extends StatefulWidget {
  const FaceAttendanceScreen({super.key});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  final FaceAttendanceService _faceService = FaceAttendanceService.instance;
  final HrService _hrService = HrService();

  StreamSubscription<Position>? _locationSubscription;
  Position? _currentPosition;
  DateTime? _lastLocationUpdate;

  bool _isProcessing = false;
  bool _isCheckedIn = false;
  bool _feedbackSuccess = true;
  String? _feedbackMessage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _faceService.stopCamera();
    super.dispose();
  }

  Future<void> _initialize() async {
    await _ensureEmployeeId();
    if (!_faceService.isInitialized) {
      await _faceService.initializeCamera();
    }
    await _refreshAttendanceStatus();
    await _setupLocationUpdates();
  }

  Future<void> _ensureEmployeeId() async {
    if (OdooRPCService.instance.currentEmployeeId != null) return;
    final employee = await _hrService.getCurrentEmployee();
    if (employee != null) {
      OdooRPCService.instance.setCurrentEmployeeId(employee.id);
    }
  }

  Future<void> _setupLocationUpdates() async {
    final permissionGranted = await _ensureLocationPermission();
    if (!permissionGranted) return;

    final current = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).catchError((_) => null);

    if (mounted && current != null) {
      setState(() {
        _currentPosition = current;
        _lastLocationUpdate = DateTime.now();
      });
    }

    _locationSubscription?.cancel();
    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((position) {
      if (!mounted) return;
      setState(() {
        _currentPosition = position;
        _lastLocationUpdate = DateTime.now();
      });
    });
  }

  Future<bool> _ensureLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setFeedback(
        'Location services are disabled. Please enable them to continue.',
        success: false,
      );
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _setFeedback(
        'Location permission denied. Please grant access from settings.',
        success: false,
      );
      return false;
    }

    return true;
  }

  Future<void> _refreshAttendanceStatus() async {
    final status = await _faceService.getCurrentAttendanceStatus();
    if (!mounted) return;
    setState(() {
      _isCheckedIn = status['is_checked_in'] == true;
    });
  }

  Future<void> _handleAttendance(AttendanceAction action) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
      _feedbackMessage = null;
    });

    try {
      final status = await _faceService.getCurrentAttendanceStatus();
      final currentlyCheckedIn = status['is_checked_in'] == true;

      if (action == AttendanceAction.checkIn && currentlyCheckedIn) {
        _setFeedback('You are already checked in.', success: false);
        return;
      }

      if (action == AttendanceAction.checkOut && !currentlyCheckedIn) {
        _setFeedback('You need to check in before checking out.', success: false);
        return;
      }

      final capture = await _showCameraAndCapture();
      if (capture == null || capture['success'] != true) {
        final error = capture?['error'] ?? 'Could not capture your face.';
        _setFeedback(error.toString(), success: false);
        return;
      }

      final latitude = (capture['latitude'] as num?)?.toDouble();
      final longitude = (capture['longitude'] as num?)?.toDouble();
      final address = capture['address'] as String?;
      final base64Image = capture['image'] as String?;

      if (base64Image == null || base64Image.isEmpty) {
        _setFeedback('Face image not captured. Please try again.', success: false);
        return;
      }

      final controllerResult = await _faceService.submitFaceViaController(
        base64Image: base64Image,
        latitude: latitude,
        longitude: longitude,
      );

      if (controllerResult['success'] == true) {
        await _refreshAttendanceStatus();
        final message = controllerResult['message'] ??
            (action == AttendanceAction.checkIn
                ? 'Check-in completed successfully.'
                : 'Check-out completed successfully.');
        _setFeedback(message, success: true);
      } else {
        _setFeedback(
          controllerResult['error']?.toString() ?? 'Attendance action failed.',
          success: false,
        );
      }
    } catch (e) {
      _setFeedback('Unexpected error: $e', success: false);
    } finally {
      await _faceService.stopCamera();
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<Map<String, dynamic>?> _showCameraAndCapture() async {
    if (!_faceService.isInitialized) {
      final initialized = await _faceService.initializeCamera();
      if (!initialized) {
        _setFeedback('Camera not available on this device.', success: false);
        return null;
      }
    }

    final controller = _faceService.cameraController;
    if (controller == null) {
      _setFeedback('Camera controller not ready.', success: false);
      return null;
    }

    await _faceService.startCamera();

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (_) {
        return _CameraCaptureSheet(
          controller: controller,
          parentContext: context,
          onCapture: () => _faceService.takeAttendancePhoto(),
        );
      },
    );

    return result;
  }

  void _setFeedback(String message, {required bool success}) {
    if (!mounted) return;
    setState(() {
      _feedbackMessage = message;
      _feedbackSuccess = success;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _openConfig() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OdooConfigScreen()),
    );
    await _refreshAttendanceStatus();
  }

  Future<void> _logout() async {
    await _faceService.stopCamera();
    OdooRPCService.instance.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final latText = _currentPosition?.latitude.toStringAsFixed(5) ?? '--';
    final lonText = _currentPosition?.longitude.toStringAsFixed(5) ?? '--';
    final updatedText = _lastLocationUpdate != null
        ? 'Updated ${TimeOfDay.fromDateTime(_lastLocationUpdate!).format(context)}'
        : 'Waiting for location...';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Smart Attendance'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _openConfig,
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configure Odoo',
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Welcome!',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What would you like to do today?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.blueGrey[500],
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        title: 'Check In',
                        subtitle:
                            _isCheckedIn ? 'Already checked in' : 'Start your workday',
                        icon: Icons.login_rounded,
                        colors: const [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                        disabled: _isProcessing || _isCheckedIn,
                        onTap: () => _handleAttendance(AttendanceAction.checkIn),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _ActionCard(
                        title: 'Check Out',
                        subtitle:
                            _isCheckedIn ? 'Wrap up your day' : 'Waiting for check-in',
                        icon: Icons.logout_rounded,
                        colors: const [Color(0xFFFF6F61), Color(0xFFD84315)],
                        disabled: _isProcessing || !_isCheckedIn,
                        onTap: () => _handleAttendance(AttendanceAction.checkOut),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _LocationCard(
                  latitude: latText,
                  longitude: lonText,
                  updatedText: updatedText,
                  server: OdooConfig.baseUrl,
                ),
                const SizedBox(height: 20),
                if (_feedbackMessage != null)
                  _FeedbackBanner(
                    message: _feedbackMessage!,
                    success: _feedbackSuccess,
                  ),
              ],
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.onTap,
    required this.disabled,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: disabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colors.last.withOpacity(0.35),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 48, color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.latitude,
    required this.longitude,
    required this.updatedText,
    required this.server,
  });

  final String latitude;
  final String longitude;
  final String updatedText;
  final String server;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Location',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    updatedText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.blueGrey[400],
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _LocationChip(label: 'Latitude', value: latitude),
              const SizedBox(width: 12),
              _LocationChip(label: 'Longitude', value: longitude),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Odoo Server',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.blueGrey[400],
                ),
          ),
          const SizedBox(height: 4),
          Text(
            server,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.blueGrey[400],
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({
    required this.message,
    required this.success,
  });

  final String message;
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: success ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: success ? Colors.green : Colors.red,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            success ? Icons.check_circle : Icons.error,
            color: success ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: success ? Colors.green[800] : Colors.red[800],
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraCaptureSheet extends StatefulWidget {
  const _CameraCaptureSheet({
    required this.controller,
    required this.parentContext,
    required this.onCapture,
  });

  final CameraController controller;
  final BuildContext parentContext;
  final Future<Map<String, dynamic>> Function() onCapture;

  @override
  State<_CameraCaptureSheet> createState() => _CameraCaptureSheetState();
}

class _CameraCaptureSheetState extends State<_CameraCaptureSheet> {
  bool _isCapturing = false;

  Future<void> _handleCapture() async {
    if (_isCapturing) return;
    setState(() {
      _isCapturing = true;
    });

    try {
      final result = await widget.onCapture();
      if (!mounted) return;

      if (result['success'] == true) {
        Navigator.of(context).pop(result);
      } else {
        final message =
            result['error']?.toString() ?? 'Capture failed. Try again.';
        ScaffoldMessenger.of(widget.parentContext).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(widget.parentContext).showSnackBar(
        SnackBar(
          content: Text('Capture error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCapturing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: CameraPreview(widget.controller),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isCapturing ? null : _handleCapture,
                  icon: _isCapturing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.camera_alt_outlined),
                  label: Text(_isCapturing ? 'Capturing...' : 'Capture & Continue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

