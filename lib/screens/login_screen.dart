// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'signup_screen.dart';
// import 'phone_login_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _email = TextEditingController();
//   final _pwd = TextEditingController();
//   bool _loading = false;

//   Future<void> _wrap(Future<void> Function() fn) async {
//     setState(() => _loading = true);
//     try { await fn(); }
//     catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())));
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: SingleChildScrollView(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//               const SizedBox(height: 40),
//               const Icon(Icons.school, size: 64, color: Color(0xFF1E3A8A)),
//               const SizedBox(height: 12),
//               const Text('BUITEMS Lost & Found',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 32),
//               TextField(controller: _email,
//                 decoration: const InputDecoration(labelText: 'Email')),
//               const SizedBox(height: 12),
//               TextField(controller: _pwd, obscureText: true,
//                 decoration: const InputDecoration(labelText: 'Password')),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _loading ? null : () => _wrap(() =>
//                   AuthService.signInWithEmail(_email.text, _pwd.text)),
//                 child: _loading
//                     ? const SizedBox(height: 20, width: 20,
//                         child: CircularProgressIndicator(strokeWidth: 2,
//                             color: Colors.white))
//                     : const Text('Sign in'),
//               ),
//               const SizedBox(height: 12),
//               OutlinedButton.icon(
//                 onPressed: _loading ? null : () =>
//                     _wrap(AuthService.signInWithGoogle),
//                 icon: const Icon(Icons.g_mobiledata, size: 28),
//                 label: const Text('Continue with Google'),
//               ),
//               const SizedBox(height: 8),
//               OutlinedButton.icon(
//                 onPressed: _loading ? null : () => Navigator.push(context,
//                     MaterialPageRoute(builder: (_) => const PhoneLoginScreen())),
//                 icon: const Icon(Icons.phone),
//                 label: const Text('Continue with Phone'),
//               ),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () => Navigator.push(context,
//                     MaterialPageRoute(builder: (_) => const SignupScreen())),
//                 child: const Text("Don't have an account? Sign up"),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
// ignore: unused_import
import 'phone_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _loading = false;
  bool _obscurePwd = true;

  Future<void> _wrap(Future<void> Function() fn) async {
    setState(() => _loading = true);
    try {
      await fn();
    } catch (e) {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
    }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A3A6E), Color(0xFF0F2347)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo + Title
                  _buildHeader(),
                  const SizedBox(height: 40),
                  // White Card
                  _buildCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'BUITEMS Lost & Found',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to reconnect with your stuff',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email field
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 14),
          // Password field
          TextField(
            controller: _pwd,
            obscureText: _obscurePwd,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePwd = !_obscurePwd),
              ),
            ),
          ),
          const SizedBox(height: 22),
          // Sign in button
          ElevatedButton(
            onPressed: _loading
                ? null
                : () => _wrap(
                    () => AuthService.signInWithEmail(_email.text, _pwd.text)),
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('Sign in'),
          ),
          const SizedBox(height: 20),
          // OR divider
          Row(children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR',
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Expanded(child: Divider()),
          ]),
          const SizedBox(height: 20),
          // Google button
          OutlinedButton(
            onPressed:
                _loading ? null : () => _wrap(AuthService.signInWithGoogle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GoogleLogo(),
                const SizedBox(width: 10),
                const Text('Continue with Google'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Sign up link
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                children: [
                  const TextSpan(text: "New here? "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupScreen())),
                      child: const Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1A3A6E),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = size.width / 2;
    final r = size.width / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    // Simple colored circle quadrants as Google logo approximation
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(Rect.fromCircle(center: Offset(c, c), radius: r),
        -1.5708, 1.5708, true, paint);
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(Rect.fromCircle(center: Offset(c, c), radius: r),
        0, 1.5708, true, paint);
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(Rect.fromCircle(center: Offset(c, c), radius: r),
        1.5708, 1.5708, true, paint);
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(Rect.fromCircle(center: Offset(c, c), radius: r),
        3.1416, 1.5708, true, paint);
    // White center
    paint.color = Colors.white;
    canvas.drawCircle(Offset(c, c), r * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
