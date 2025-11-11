import 'package:flutter/material.dart';

import '../config/odoo_config.dart';
import '../services/local_storage_service.dart';
import '../services/odoo_rpc_service.dart';
import 'login_screen.dart';

class OdooConfigScreen extends StatefulWidget {
  const OdooConfigScreen({super.key});

  @override
  State<OdooConfigScreen> createState() => _OdooConfigScreenState();
}

class _OdooConfigScreenState extends State<OdooConfigScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _databaseController = TextEditingController();

  bool _isBusy = false;
  String? _feedback;
  bool _feedbackSuccess = true;

  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  @override
  void dispose() {
    _urlController.dispose();
    _databaseController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedValues() async {
    final storage = LocalStorageService();
    final savedUrl = await storage.getOdooUrl();
    final savedDb = await storage.getOdooDatabase();

    setState(() {
      _urlController.text = savedUrl ?? 'http://localhost:8069';
      _databaseController.text = savedDb ?? 'hr';
    });
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBusy = true;
    });

    try {
      await OdooConfig.updateConfiguration(
        _urlController.text.trim(),
        _databaseController.text.trim(),
      );

      final storage = LocalStorageService();
      await storage.setFirstLoginCompleted();

      _showFeedback('Configuration saved successfully.', success: true);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      _showFeedback('Failed to save configuration: $e', success: false);
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  Future<void> _handleTestConnection() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBusy = true;
    });

    final trimmedUrl = _urlController.text.trim();
    final trimmedDb = _databaseController.text.trim();
    final originalUrl = OdooConfig.baseUrl;
    final originalDb = OdooConfig.database;

    try {
      await OdooConfig.updateConfiguration(trimmedUrl, trimmedDb);

      final result = await OdooRPCService.instance.testConnection();
      if (result['success'] == true) {
        _showFeedback(
          'Successfully reached Odoo server at $trimmedUrl.',
          success: true,
        );
      } else {
        _showFeedback(
          result['error']?.toString() ??
              'Server responded with status ${result['statusCode']}',
          success: false,
        );
      }
    } catch (e) {
      _showFeedback('Connection test failed: $e', success: false);
    } finally {
      await OdooConfig.updateConfiguration(originalUrl, originalDb);
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  void _showFeedback(String message, {required bool success}) {
    if (!mounted) return;
    setState(() {
      _feedback = message;
      _feedbackSuccess = success;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  Future<void> _restoreDefaults() async {
    setState(() {
      _urlController.text = 'http://localhost:8069';
      _databaseController.text = 'hr';
      _feedback = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Odoo Server Setup'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _isBusy ? null : _restoreDefaults,
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        offset: Offset(0, 12),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.cloud_sync,
                              color: Colors.blue[600],
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Connect Your Workspace',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueGrey[900],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Enter the Odoo server URL and database name provided by your administrator.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.blueGrey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_feedback != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:
                                _feedbackSuccess ? Colors.green[50] : Colors.red[50],
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _feedbackSuccess ? Colors.green : Colors.red,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                _feedbackSuccess ? Icons.check_circle : Icons.warning,
                                color: _feedbackSuccess ? Colors.green : Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _feedback!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color:
                                        _feedbackSuccess ? Colors.green[800] : Colors.red[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'Odoo URL',
                    hintText: 'https://company.odoo.com',
                    prefixIcon: const Icon(Icons.link),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Server URL is required';
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null || (!uri.hasScheme && !uri.hasAuthority)) {
                      return 'Enter a valid URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _databaseController,
                  decoration: InputDecoration(
                    labelText: 'Database Name',
                    hintText: 'my_odoo_database',
                    prefixIcon: const Icon(Icons.storage_outlined),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Database name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Database name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isBusy ? null : _handleTestConnection,
                        icon: const Icon(Icons.wifi_tethering),
                        label: const Text('Test Connection'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue[700],
                          side: BorderSide(color: Colors.blue[200]!),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isBusy ? null : _handleSave,
                        icon: _isBusy
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(_isBusy ? 'Saving...' : 'Save & Continue'),
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
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need help?',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• The URL should point to your Odoo instance (cloud or on-premise).\n'
                        '• Use the database name configured for your company.\n'
                        '• Tap "Test Connection" to verify the details before saving.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.blueGrey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
