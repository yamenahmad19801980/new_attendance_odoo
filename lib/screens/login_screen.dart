import 'package:flutter/material.dart';

import '../generated/l10n/app_localizations.dart';
import '../services/odoo_rpc_service.dart';
import 'home/home_screen.dart';
import '../services/hr_service.dart';
import '../services/local_storage_service.dart';
import '../config/odoo_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _prefillSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _prefillSavedCredentials() async {
    final storage = LocalStorageService();
    final savedEmail = await storage.getSavedEmail();
    final savedPassword = await storage.getSavedPassword();

    if (!mounted) return;

    setState(() {
      if (savedEmail != null) {
        _emailController.text = savedEmail;
      }
      if (savedPassword != null) {
        _passwordController.text = savedPassword;
      }
    });
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Attempt to authenticate
        print('Attempting authentication with: ${_emailController.text}');
        final result = await OdooRPCService.instance.authenticate(
          username: _emailController.text.trim(),
          password: _passwordController.text,
          database: OdooConfig.database,
        );

        print('Authentication result: $result');

        if (result['success'] == true) {
          final storage = LocalStorageService();
          await storage.saveLastCredentials(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

          await OdooRPCService.instance.trackLoginTime();

          final hrService = HrService();
          final employee = await hrService.getCurrentEmployee();
          if (employee != null) {
            OdooRPCService.instance.setCurrentEmployeeId(employee.id);
          }

          if (!mounted) return;
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.welcomeName(employee?.name ?? _emailController.text.trim()),
              ),
              backgroundColor: Colors.green,
            ),
          );

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['error'] ?? AppLocalizations.of(context)!.authFailed),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        print('Login error: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.connectionError(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: Text(l10n.signIn),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.verified_user,
                          size: 42,
                          color: Color(0xFF6B46C1),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.secureAccess,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.connectWorkspace,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.blueGrey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: l10n.username,
                    prefixIcon: const Icon(Icons.person_outline),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.usernameRequired;
                    }
                    // if (!RegExp(
                    //   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    // ).hasMatch(value.trim())) {
                    //   return l10n.emailInvalid;
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: l10n.password,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.passwordRequired;
                    }
                    if (value.length < 4) {
                      return l10n.passwordMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                   
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          l10n.signIn,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 24),
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Current Server',
                //         style: Theme.of(context).textTheme.labelMedium
                //             ?.copyWith(color: Colors.blueGrey[400]),
                //       ),
                //       const SizedBox(height: 6),
                //       Text(
                //         OdooConfig.baseUrl,
                //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       const SizedBox(height: 8),
                //       Text(
                //         'Database: ${OdooConfig.database}',
                //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //           color: Colors.blueGrey[500],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
