import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/mobile_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const BuitemsApp());
}

class BuitemsApp extends StatelessWidget {
  const BuitemsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUITEMS Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snap.data == null) return const LoginScreen();
          return const MobileShell();
        },
      ),
    );
  }
}
