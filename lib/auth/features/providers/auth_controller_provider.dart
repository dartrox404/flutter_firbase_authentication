import 'package:flutter_auth/auth/features/providers/google_service_provider.dart';
import 'package:flutter_auth/auth/features/services/google_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final authControllerProvider = StateNotifierProvider<GoogleController, bool>((
  ref,
) {
  return GoogleController(ref.watch(googleServiceProvider));
});
