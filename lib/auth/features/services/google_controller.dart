import 'package:flutter_auth/auth/features/services/google_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class GoogleController extends StateNotifier<bool> {
  final GoogleService _instance;
  GoogleController(this._instance) : super(false);

  Future<void> loginin() async {
    state = true;
    try {
      await _instance.loginwihtgoogle();
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      state = false;
    }
  }

  Future<void> forgetpassword(String a) async {
    state = true;
    try {
      await _instance.forgetpassword(a);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      state = false;
    }
  }

  Future<void> signout() async {
    await _instance.logout();
  }
}
