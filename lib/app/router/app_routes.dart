import 'package:aaraadhya_temple_dashboard/app/router/app_route.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/signin/signin_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/splash/splash_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bookings/bookings_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bottom_nav/bottom_nav_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/dashboard/dashboard_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/donations/donations_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/events_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/more/more_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/profile_settings/profile_settings_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/schedule_pooja_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/registrations/view_registrations/view_registrations_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static AppRoute splash = AppRoute(
    SplashScreen(),
    name: 'splash',
    path: '/splash',
  );

  static AppRoute signin = AppRoute(
    SigninScreen(),
    name: 'signin',
    path: '/signin',
  );

  static AppRoute forgotPassword = AppRoute(
    ForgotPasswordScreen(),
    name: 'forgot-password',
    path: '/forgot-password',
  );

  static AppRoute bottomNavScreen({required Widget child}) => AppRoute(
    BottomNavScreen(child: child),
    name: 'bottom-nav-screen',
    path: '/bottom-nav-screen',
  );

  static AppRoute dashboard = AppRoute(
    DashboardScreen(),
    name: 'dashboard',
    path: '/dashboard',
  );

  static AppRoute bookings = AppRoute(
    BookingsScreen(),
    name: 'bookings',
    path: '/bookings',
  );

  static AppRoute donations = AppRoute(
    DonationsScreen(),
    name: 'donations',
    path: '/donations',
  );

  static AppRoute events = AppRoute(
    EventsScreen(),
    name: 'events',
    path: '/events',
  );

  static AppRoute more = AppRoute(MoreScreen(), name: 'more', path: '/more');

  static AppRoute viewRegistration = AppRoute(
    ViewRegistrationsScreen(),
    name: 'view-registration',
    path: '/view-registration',
  );

  static AppRoute profileSettingsScreen = AppRoute(
    ProfileSettingsScreen(),
    name: 'profile-settings-screen',
    path: '/profile-settings-screen',
  );

  static AppRoute schedulePoojaScreen = AppRoute(
    SchedulePoojaScreen(),
    name: 'schedule-pooja-screen',
    path: '/schedule-pooja-screen',
  );
}
