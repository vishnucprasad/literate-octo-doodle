import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/signin/signin_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/splash/splash_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/bookings_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bottom_nav/bottom_nav_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/dashboard_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/donations/donations_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/events_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/more/more_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/registrations/view_registrations/view_registrations_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  final String name;
  final String path;
  final Widget screen;

  AppRoute({required this.name, required this.path, required this.screen});
}

class AppRoutes {
  static AppRoute splash = AppRoute(
    name: 'splash',
    path: '/splash',
    screen: SplashScreen(),
  );

  static AppRoute signin = AppRoute(
    name: 'signin',
    path: '/signin',
    screen: SigninScreen(),
  );

  static AppRoute forgotPassword = AppRoute(
    name: 'forgot-password',
    path: '/forgot-password',
    screen: ForgotPasswordScreen(),
  );

  static AppRoute bottomNavScreen({required Widget child}) => AppRoute(
    name: 'bottom-nav-screen',
    path: '/bottom-nav-screen',
    screen: BottomNavScreen(child: child),
  );

  static AppRoute dashboard = AppRoute(
    name: 'dashboard',
    path: '/dashboard',
    screen: DashboardScreen(),
  );

  static AppRoute bookings = AppRoute(
    name: 'bookings',
    path: '/bookings',
    screen: BookingsScreen(),
  );

  static AppRoute donations = AppRoute(
    name: 'donations',
    path: '/donations',
    screen: DonationsScreen(),
  );

  static AppRoute events = AppRoute(
    name: 'events',
    path: '/events',
    screen: EventsScreen(),
  );

  static AppRoute more = AppRoute(
    name: 'more',
    path: '/more',
    screen: MoreScreen(),
  );

  static AppRoute viewRegistration = AppRoute(
    name: 'view-registration',
    path: '/view-registration',
    screen: ViewRegistrationsScreen(),
  );
}
