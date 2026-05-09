import 'package:flutter_auth/auth/features/services/auth_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authMethodProvider = Provider<AuthMethod>((ref) => AuthMethod());
