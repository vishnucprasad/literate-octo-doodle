import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/signin/signin_screen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/auth/splash/splash_screen.dart';
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
}
