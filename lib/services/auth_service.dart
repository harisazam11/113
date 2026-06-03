import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;
  static Stream<User?> get authState => _auth.authStateChanges();

  static bool _isBuitemsEmail(String email) {
    final e = email.trim().toLowerCase();
    return e.endsWith('@student.buitms.edu.pk') || e.endsWith('.buitems.edu.pk');
  }

  static Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!_isBuitemsEmail(email)) {
      throw FirebaseAuthException(
        code: 'invalid-domain',
        message: 'Use your @buitems.edu.pk email to sign up.',
      );
    }
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(), password: password,
    );
    await cred.user!.updateDisplayName(name);
    await _db.collection('users').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'name': name,
      'email': email.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  static Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(code: 'cancelled', message: 'Sign-in cancelled');
    }
    final googleAuth = await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken, accessToken: googleAuth.accessToken,
    );
    final userCred = await _auth.signInWithCredential(cred);
    final user = userCred.user!;
    if (user.email == null || !_isBuitemsEmail(user.email!)) {
    await _auth.signOut();
    throw FirebaseAuthException(
    code: 'invalid-email-domain',
    message: 'Only BUITEMS email allowed',
  );
}
    final doc = _db.collection('users').doc(user.uid);
    if (!(await doc.get()).exists) {
      await doc.set({
        'uid': user.uid,
        'name': user.displayName ?? 'Student',
        'email': user.email ?? '',
        'department': '',
        'semester': '',
        'phone': '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  static Future<String> sendPhoneCode(String phone) {
    final completer = Completer<String>();
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        if (!completer.isCompleted) completer.completeError(e);
      },
      codeSent: (id, _) {
        if (!completer.isCompleted) completer.complete(id);
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    return completer.future;
  }

  static Future<void> confirmPhoneCode(String verificationId, String smsCode) async {
    final cred = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: smsCode,
    );
    final userCred = await _auth.signInWithCredential(cred);
    final user = userCred.user!;
    final doc = _db.collection('users').doc(user.uid);
    if (!(await doc.get()).exists) {
      await doc.set({
        'uid': user.uid,
        'name': user.displayName ?? 'Student',
        'email': user.email ?? '',
        'phone': user.phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  static Future<void> signOut() async {
    try { await GoogleSignIn().signOut(); } catch (_) {}
    await _auth.signOut();
  }
}
