import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        builder: (context, state) => AppRoutes.splash.screen,
      ),
      GoRoute(
        path: AppRoutes.signin.path,
        name: AppRoutes.signin.name,
        builder: (context, state) => AppRoutes.signin.screen,
      ),
      GoRoute(
        path: AppRoutes.forgotPassword.path,
        name: AppRoutes.forgotPassword.name,
        builder: (context, state) => AppRoutes.forgotPassword.screen,
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppRoutes.bottomNavScreen(child: child).screen;
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboard.path,
            name: AppRoutes.dashboard.name,
            builder: (context, state) => AppRoutes.dashboard.screen,
          ),
          GoRoute(
            path: AppRoutes.bookings.path,
            name: AppRoutes.bookings.name,
            builder: (context, state) => AppRoutes.bookings.screen,
          ),
          GoRoute(
            path: AppRoutes.donations.path,
            name: AppRoutes.donations.name,
            builder: (context, state) => AppRoutes.donations.screen,
          ),
          GoRoute(
            path: AppRoutes.events.path,
            name: AppRoutes.events.name,
            builder: (context, state) => AppRoutes.events.screen,
          ),
          GoRoute(
            path: AppRoutes.more.path,
            name: AppRoutes.more.name,
            builder: (context, state) => AppRoutes.more.screen,
          ),
        ],
      ),
    ],
  );
}
