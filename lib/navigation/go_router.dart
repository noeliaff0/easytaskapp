import 'package:go_router/go_router.dart';

import 'package:easytaskapp/presentation/providers/auth.provider.dart';
import 'package:easytaskapp/presentation/screens/home.screen.dart';
import 'package:easytaskapp/presentation/screens/login_screen.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
    ],
  );
}
