import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'config/odoo_config.dart';
import 'screens/odoo_config_screen.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Odoo configuration on app start
  await OdooConfig.loadConfiguration();

  runApp(const HrApp());
}

class HrApp extends StatelessWidget {
  const HrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const _StartupRouter(),
    );
  }
}

enum _StartupDestination { config, login }

class _StartupRouter extends StatelessWidget {
  const _StartupRouter({super.key});

  Future<_StartupDestination> _resolveDestination() async {
    final storage = LocalStorageService();
    final savedUrl = await storage.getOdooUrl();
    final savedDatabase = await storage.getOdooDatabase();
    final isFirstLogin = await storage.isFirstLogin();

    final hasConfig =
        (savedUrl != null && savedUrl.isNotEmpty) &&
        (savedDatabase != null && savedDatabase.isNotEmpty);

    if (!hasConfig || isFirstLogin) {
      return _StartupDestination.config;
    }

    return _StartupDestination.login;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_StartupDestination>(
      future: _resolveDestination(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == _StartupDestination.config) {
          return const OdooConfigScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
