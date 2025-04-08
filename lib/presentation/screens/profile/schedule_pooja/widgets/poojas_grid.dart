import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/profile/schedule_pooja/widgets/view_pooja_details_dialog.dart';
import 'package:flutter/material.dart';

class PoojasGrid extends StatelessWidget {
  const PoojasGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      childAspectRatio: 3 / 4,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      crossAxisCount: 2,
      children: List.generate(20, (index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              barrierColor: context.colorScheme.surface,
              barrierDismissible: false,
              builder: (context) => ViewPoojaDetailsDialog(),
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://i.pinimg.com/736x/56/22/bf/5622bf0a3b82f3947fd6bf946a2925eb.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [context.colors.black, Colors.transparent],
                      stops: [0.0, 1],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index % 2 == 0 ? 'Abhishekam' : 'Archana',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.verticalSmall,
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
