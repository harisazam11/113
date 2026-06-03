// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _name = TextEditingController();
//   final _email = TextEditingController();
//   final _pwd = TextEditingController();
//   bool _loading = false;

//   Future<void> _submit() async {
//     setState(() => _loading = true);
//     try {
//       await AuthService.signUpWithEmail(
//         name: _name.text.trim(),
//         email: _email.text, password: _pwd.text,
//       );
//       if (mounted) Navigator.pop(context);
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create account')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           TextField(controller: _name,
//               decoration: const InputDecoration(labelText: 'Full name')),
//           const SizedBox(height: 12),
//           TextField(controller: _email,
//               decoration: const InputDecoration(
//                 labelText: 'BUITEMS Email (@buitems.edu.pk)')),
//           const SizedBox(height: 12),
//           TextField(controller: _pwd, obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password')),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: _loading ? null : _submit,
//             child: _loading
//               ? const SizedBox(height: 20, width: 20,
//                   child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
//               : const Text('Sign up'),
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _phone = TextEditingController();
  final _customDepartment = TextEditingController();
  bool _loading = false;
  bool _obscurePwd = true;
  String? _department;
  String? _semester;

  static const List<String> _departments = [
    'Computer Science',
    'Software Engineering',
    'Information Technology',
    'Artificial Intelligence',
    'Data Science',
    'Cyber Security',
    'Electrical Engineering',
    'Electronics Engineering',
    'Civil Engineering',
    'Mechanical Engineering',
    'Architecture',
    'Business Administration',
    'Management Sciences',
    'Accounting & Finance',
    'Economics',
    'Pharmacy',
    'Biotechnology',
    'Mathematics',
    'Physics',
    'Chemistry',
    'English',
    'Education',
    'Other',
  ];

  static const List<String> _semesters = [
    '1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th',
  ];

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      await AuthService.signUpWithEmail(
        name: _name.text.trim(),
        email: _email.text,
        password: _pwd.text,
        department: _department == 'Other'
          ? _customDepartment.text.trim()
          : (_department ?? ''),
        semester: _semester ?? '',
        phone: _phone.text.trim(),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
        );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pwd.dispose();
    _phone.dispose();
    _customDepartment.dispose();
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
          child: Column(
            children: [
              // Top bar with back button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
                  child: Column(
                    children: [
                      // Header
                      _buildHeader(),
                      const SizedBox(height: 28),
                      // Card
                      _buildCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Create account',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'BUITEMS students only',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.65),
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
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.person_outline, size: 20),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'BUITEMS email',
              hintText: 'you@buitems.edu.pk',
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 14),
          // Department dropdown
          DropdownButtonFormField<String>(
            value: _department,
            decoration: const InputDecoration(
              labelText: 'Department',
              prefixIcon: Icon(Icons.account_balance_outlined, size: 20),
            ),
            items: _departments
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (v) => setState(() => _department = v),
          ),
          if (_department == 'Other') ...[
            const SizedBox(height: 14),
            TextField(
              controller: _customDepartment,
              decoration: const InputDecoration(
                labelText: 'Enter Department',
                hintText: 'Type your department',
                prefixIcon: Icon(Icons.edit_outlined, size: 20),
              ),
            ),
          ],
          const SizedBox(height: 14),
          // Semester dropdown
          DropdownButtonFormField<String>(
            value: _semester,
            decoration: const InputDecoration(
              labelText: 'Semester',
              prefixIcon: Icon(Icons.school_outlined, size: 20),
            ),
            items: _semesters
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => _semester = v),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone',
              hintText: '+92 300 0000000',
              prefixIcon: Icon(Icons.phone_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 14),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loading ? null : _submit,
            child: _loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Text('Create account'),
          ),
          const SizedBox(height: 20),
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
          OutlinedButton(
            onPressed: _loading ? null : () {},
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
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Sign in',
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
    paint.color = Colors.white;
    canvas.drawCircle(Offset(c, c), r * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
