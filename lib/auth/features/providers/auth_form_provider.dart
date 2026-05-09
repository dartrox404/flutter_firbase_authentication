import 'package:flutter_auth/auth/data/model/auth_state.dart';
import 'package:flutter_auth/auth/features/services/auth_validator.dart';
import 'package:riverpod/legacy.dart';

final authSignupNotify = StateNotifierProvider<AuthValidator, AuthState>(
  (ref) => AuthValidator(),
);
final authLoginNotify = StateNotifierProvider<AuthValidator, AuthState>(
  (ref) => AuthValidator(),
);
