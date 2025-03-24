import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavScreen extends StatelessWidget {
  final Widget child;

  const BottomNavScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: GNav(
          haptic: true,
          tabBorderRadius: 8,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 500),
          gap: 4,
          color: context.colors.grey[900],
          activeColor: context.colors.white,
          iconSize: 20,
          tabBackgroundColor: context.colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          onTabChange: (index) {
            switch (index) {
              case 0:
                context.go(AppRoutes.dashboard.path);
                break;
              case 1:
                context.go(AppRoutes.bookings.path);
                break;
              case 2:
                context.go(AppRoutes.donations.path);
                break;
              case 3:
                context.go(AppRoutes.events.path);
                break;
              case 4:
                context.go(AppRoutes.more.path);
                break;
            }
          },
          tabs: [
            GButton(icon: Icons.dashboard, text: 'Dashboard'),
            GButton(icon: Icons.confirmation_num_outlined, text: 'Bookings'),
            GButton(icon: Icons.monetization_on_outlined, text: 'Donations'),
            GButton(icon: Icons.event_outlined, text: 'Events'),
            GButton(icon: Icons.more_horiz, text: 'More'),
          ],
        ),
      ),
    );
  }
}
