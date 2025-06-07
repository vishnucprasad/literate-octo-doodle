import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/home_app_bar.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/expandable_container/expandable_container_controller.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/registrations/view_registrations/widgets/listof_registrations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewRegistrationsScreen extends ConsumerWidget {
  const ViewRegistrationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(expandableContainerControllerProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setIndex(null);
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.setIndex(null);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: HomeAppBar(
            title: context.l10n.viewRegistrationsAppBarTitle,
            actions: [],
          ),
        ),
        body: SafeArea(child: ListofRegistrations()),
      ),
    );
  }
}
