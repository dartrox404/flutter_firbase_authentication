import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final google = GoogleSignIn.instance;
  bool intalize = false;

  Future<void> intialize() async {
    if (intalize) return;
    await google.initialize(
      clientId:
          "543942042647-8busbahndaud3jrvfbv8nhp0hajgjnnf.apps.googleusercontent.com",
    );
    intalize = true;
  }

  Future<void> loginwihtgoogle() async {
    try {
      await intialize();
      final GoogleSignInAccount? googleuser = await google.authenticate();
      if (googleuser == null) return;
      final GoogleSignInAuthentication userab = googleuser.authentication;
      final cred = GoogleAuthProvider.credential(idToken: userab.idToken);
      final actualUserCred = await auth.signInWithCredential(cred);
      await _saveUserdata(actualUserCred.user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _saveUserdata(User? user) async {
    if (user != null) {
      final x = firestore.collection('users').doc(user.uid);
      final a = await x.get();
      if (!a.exists) {
        await x.set({
          "name": user.displayName,
          "email": user.email,
          "createdAT": FieldValue.serverTimestamp(),
        });
      }
    }
  }

  Future<void> forgetpassword(String a) async {
    try {
      await auth.sendPasswordResetEmail(email: a.trim());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    await google.signOut();
  }
}
