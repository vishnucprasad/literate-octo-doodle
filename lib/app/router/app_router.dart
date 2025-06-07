import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/auth/auth_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/notification/notification_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authControllerProvider);
  final isTappedOnNotification = ref.watch(
    notificationControllerProvider.select(
      (state) => state.isTappedOnNotification,
    ),
  );

  return GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        redirect: (context, state) {
          if (authState.isAuthenticating) {
            return AppRoutes.splash.path;
          }
          if (authState.user != null) {
            return isTappedOnNotification
                ? AppRoutes.payments.path
                : AppRoutes.dashboard.path;
          }
          return AppRoutes.signin.path;
        },
        builder: AppRoutes.splash.builder,
      ),
      GoRoute(
        path: AppRoutes.signin.path,
        name: AppRoutes.signin.name,
        builder: AppRoutes.signin.builder,
      ),
      GoRoute(
        path: AppRoutes.forgotPassword.path,
        name: AppRoutes.forgotPassword.name,
        pageBuilder: AppRoutes.forgotPassword.slideTransitionBuilder,
      ),
      GoRoute(
        path: AppRoutes.viewRegistration.path,
        name: AppRoutes.viewRegistration.name,
        pageBuilder: AppRoutes.viewRegistration.slideTransitionBuilder,
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppRoutes.bottomNavScreen(
            child: child,
          ).builder(context, state);
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboard.path,
            name: AppRoutes.dashboard.name,
            pageBuilder: AppRoutes.dashboard.revealTransitionBuilder,
          ),
          GoRoute(
            path: AppRoutes.bookings.path,
            name: AppRoutes.bookings.name,
            pageBuilder: AppRoutes.bookings.revealTransitionBuilder,
          ),
          GoRoute(
            path: AppRoutes.payments.path,
            name: AppRoutes.payments.name,
            pageBuilder: AppRoutes.payments.revealTransitionBuilder,
          ),
          GoRoute(
            path: AppRoutes.events.path,
            name: AppRoutes.events.name,
            pageBuilder: AppRoutes.events.revealTransitionBuilder,
          ),
          GoRoute(
            path: AppRoutes.more.path,
            name: AppRoutes.more.name,
            pageBuilder: AppRoutes.more.revealTransitionBuilder,
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.notifications.path,
        name: AppRoutes.notifications.name,
        pageBuilder: AppRoutes.notifications.slideTransitionBuilder,
      ),
      GoRoute(
        path: AppRoutes.profileSettingsScreen.path,
        name: AppRoutes.profileSettingsScreen.name,
        pageBuilder: AppRoutes.profileSettingsScreen.slideTransitionBuilder,
      ),
      GoRoute(
        path: AppRoutes.schedulePoojaScreen.path,
        name: AppRoutes.schedulePoojaScreen.name,
        pageBuilder: AppRoutes.schedulePoojaScreen.slideTransitionBuilder,
      ),
    ],
  );
}
