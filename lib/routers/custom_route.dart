import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/auth/features/pages/homepage.dart';
import 'package:flutter_auth/auth/features/pages/login.dart';
import 'package:flutter_auth/auth/features/pages/signup.dart';
import 'package:go_router/go_router.dart';

class CustomRoute {
  static final GoRouter approute = GoRouter(
    redirect: (context, state) {
      final auth = FirebaseAuth.instance.currentUser;
      final route = state.uri.path == "/login" || state.uri.path == "/signup";
      if (auth != null && route) {
        return '/home';
      }
      if (auth == null && !route) {
        return '/login';
      }
      return null;
    },
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const Login()),
      GoRoute(path: '/signup', builder: (context, state) => const Signup()),
      GoRoute(path: '/home', builder: (context, state) => const Homepage()),
    ],
  );
}
