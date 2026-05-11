import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  static final auth = FirebaseAuth.instance;
  static final firestore = FirebaseFirestore.instance;

  Future<String> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      UserCredential User = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(User.user!.uid).set({
        "name": name,
        "email": email,
        "Uid": User.user!.uid,
        "createdAt": FieldValue.serverTimestamp(),
      });
      return "success";
    } on FirebaseAuthException catch (e) {
      return error(e);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "true";
    } on FirebaseAuthException catch (e) {
      return error(e);
    } catch (x) {
      return x.toString();
    }
  }

  String error(FirebaseAuthException a) {
    switch (a.code) {
      case "user-not-found":
        return "User not found with this email";
      case "email-already-in-use":
        return "Email is already in use";
      case "weak-password":
        return "Password is too weak try stronger one";
      case "invalid email":
        return "Email is invalid try different one";
      case "wrong-password":
        return "Invalid password try again!";
      case "user-disabled":
        return "User is disabled or ban";
      case "too-many-requests":
        return "Server is getting too much request try again in few minutes";
      case "network-request-failed":
        return "Network request failed try again";
      default:
        return a.message ?? "Unexpected error occur";
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
