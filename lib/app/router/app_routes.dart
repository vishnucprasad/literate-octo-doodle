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
}
