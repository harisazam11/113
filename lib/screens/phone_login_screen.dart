// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class PhoneLoginScreen extends StatefulWidget {
//   const PhoneLoginScreen({super.key});
//   @override
//   State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
// }

// class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
//   final _phone = TextEditingController(text: '+92');
//   final _code = TextEditingController();
//   String? _verificationId;
//   bool _loading = false;

//   Future<void> _sendCode() async {
//     setState(() => _loading = true);
//     try {
//       final id = await AuthService.sendPhoneCode(_phone.text.trim());
//       setState(() => _verificationId = id);
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())));
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   Future<void> _verify() async {
//     setState(() => _loading = true);
//     try {
//       await AuthService.confirmPhoneCode(_verificationId!, _code.text.trim());
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
//       appBar: AppBar(title: const Text('Phone sign-in')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           TextField(controller: _phone, keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: 'Phone number (with country code)')),
//           const SizedBox(height: 16),
//           if (_verificationId == null)
//             ElevatedButton(
//               onPressed: _loading ? null : _sendCode,
//               child: const Text('Send code'),
//             )
//           else ...[
//             TextField(controller: _code, keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'SMS code')),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _loading ? null : _verify,
//               child: const Text('Verify & sign in'),
//             ),
//           ],
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});
  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phone = TextEditingController(text: '+92');
  final _code = TextEditingController();
  String? _verificationId;
  bool _loading = false;

  Future<void> _sendCode() async {
    setState(() => _loading = true);
    try {
      final id = await AuthService.sendPhoneCode(_phone.text.trim());
      setState(() => _verificationId = id);
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

  Future<void> _verify() async {
    setState(() => _loading = true);
    try {
      await AuthService.confirmPhoneCode(
          _verificationId!, _code.text.trim());
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
    _phone.dispose();
    _code.dispose();
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.phone_android_rounded,
                            size: 38, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Phone sign-in',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _verificationId == null
                            ? 'Enter your phone number to receive a code'
                            : 'Enter the SMS code sent to your phone',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.65),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Card
                      Container(
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
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              TextField(
                                controller: _phone,
                                keyboardType: TextInputType.phone,
                                enabled: _verificationId == null,
                                decoration: const InputDecoration(
                                  labelText: 'Phone number',
                                  hintText: '+92 300 0000000',
                                  prefixIcon: Icon(Icons.phone_outlined,
                                      size: 20),
                                ),
                              ),
                              if (_verificationId != null) ...[
                                const SizedBox(height: 14),
                                TextField(
                                  controller: _code,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    letterSpacing: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    labelText: 'SMS code',
                                    hintText: '______',
                                    prefixIcon: Icon(
                                        Icons.sms_outlined,
                                        size: 20),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _loading
                                    ? null
                                    : (_verificationId == null
                                        ? _sendCode
                                        : _verify),
                                child: _loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white))
                                    : Text(
                                        _verificationId == null
                                            ? 'Send code'
                                            : 'Verify & sign in',
                                      ),
                              ),
                              if (_verificationId != null) ...[
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed: () => setState(
                                      () => _verificationId = null),
                                  child: const Text(
                                    'Use a different number',
                                    style: TextStyle(
                                        color: Color(0xFF64748B),
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ]),
                      ),
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
}
