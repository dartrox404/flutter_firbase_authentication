import 'package:flutter_auth/auth/data/model/auth_state.dart';
import 'package:riverpod/legacy.dart';

class AuthValidator extends StateNotifier<AuthState> {
  AuthValidator() : super(AuthState());
  void tooglepassword() {
    state = state.copyWith(ispasswordhidden: !state.ispasswordhidden);
  }

  void setloading(bool a) {
    state = state.copyWith(isloading: a);
  }

  void updateName(String a) {
    String? error = _namerror(a);
    state = state.copyWith(name: a, namerror: error);
  }

  void updateEmail(String a) {
    String? error = _emailerror(a);
    state = state.copyWith(email: a, emailerror: error);
  }

  void updatePassword(String a) {
    String? error = _passworderror(a);
    state = state.copyWith(password: a, passworderror: error);
  }

  String? _namerror(String x) {
    if (x.isEmpty) return "Name is Required";
    if (x.length < 3) return "Name must be atleast 3 characters";
    if (x.length > 50) return "Name is too long";
    return null;
  }

  String? _passworderror(String x) {
    if (x.isEmpty) return "Password is Required";
    if (x.length < 6) return "Password must be atleast 6 characters";
    if (x.length > 100) return "Password is too long";
    return null;
  }

  String? _emailerror(String x) {
    if (x.isEmpty) return "Email is Required";
    final reg = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!reg.hasMatch(x)) return "Enter Valid email";
    return null;
  }
}
