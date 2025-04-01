import 'package:aaraadhya_temple_dashboard/app/router/app_routes.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/bottom_nav/widgets/rupee_icon.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/home/events/widgets/event_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavScreen extends HookConsumerWidget {
  final Widget child;

  const BottomNavScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndexNotifier = useState<int>(0);
    final controller = ref.read(expandableContainerControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexNotifier.value,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        selectedItemColor: context.colorScheme.primary,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: context.colors.grey[900],
        showUnselectedLabels: true,
        onTap: (index) {
          controller.setIndex(null);
          currentIndexNotifier.value = index;

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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            activeIcon: Icon(Icons.confirmation_num),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: RupeeIcon(
              borderColor: context.colorScheme.onSurface,
              backgroundColor: context.colorScheme.surface,
              iconColor: context.colorScheme.onSurface,
            ),
            activeIcon: RupeeIcon(
              borderColor: context.colorScheme.primary,
              backgroundColor: context.colorScheme.primary,
              iconColor: context.colorScheme.surface,
            ),
            label: 'Donations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            activeIcon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
      ),
      floatingActionButton:
          currentIndexNotifier.value == 3
              ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => EventForm(),
                  );
                },
                shape: CircleBorder(),
                backgroundColor: context.colorScheme.primary,
                child: Icon(Icons.add),
              )
              : null,
    );
  }
}
