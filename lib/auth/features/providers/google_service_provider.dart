import 'package:flutter_auth/auth/features/services/google_service.dart';
import 'package:riverpod/riverpod.dart';

final googleServiceProvider = Provider<GoogleService>((ref) => GoogleService());
