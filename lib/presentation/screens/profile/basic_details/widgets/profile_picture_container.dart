import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/custom_painters/dotted_border_painter.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/shimmer_loader.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/basic_details/basic_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePictureContainer extends ConsumerWidget {
  const ProfilePictureContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(basicDetailsControllerProvider);
    final controller = ref.read(basicDetailsControllerProvider.notifier);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.grey[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoader(
            isLoading: state.isLoading,
            showBackground: true,
            child: Text(
              context.l10n.profilePictureLabel,
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSpacing.verticalMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: FittedBox(
                  child: ShimmerLoader(
                    isLoading: state.isLoading,
                    child: CircleAvatar(
                      backgroundColor: context.colors.primary[50],
                      foregroundImage:
                          state.basicDetails.profilePictureUrl != null
                              ? NetworkImage(
                                state.basicDetails.profilePictureUrl!,
                              )
                              : null,
                      child:
                          state.basicDetails.profilePictureUrl == null
                              ? Icon(
                                Icons.temple_hindu_outlined,
                                color: context.colorScheme.primary,
                              )
                              : ShimmerLoader(
                                isLoading: true,
                                child: CircleAvatar(),
                              ),
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalMedium,
              Expanded(
                child: ShimmerLoader(
                  isLoading: state.isLoading,
                  child: GestureDetector(
                    onTap: controller.uploadProfilePicture,
                    child: CustomPaint(
                      painter: DottedBorderPainter(color: context.colors.grey),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: context.colors.primary[50],
                              child:
                                  state.isUploading
                                      ? SizedBox.square(
                                        dimension: 36.0,
                                        child: CircularProgressIndicator(),
                                      )
                                      : Icon(
                                        Icons.upload_outlined,
                                        size: 36.0,
                                        color: context.colorScheme.primary,
                                      ),
                            ),
                            AppSpacing.verticalSmall,
                            Text(
                              context.l10n.uploadNewImageLabel,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            AppSpacing.verticalSmall,
                            Text(
                              context.l10n.imageTypeAndSizeLabel,
                              style: context.theme.textTheme.bodySmall
                                  ?.copyWith(fontFamily: FontFamily.roboto),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalSmall,
            ],
          ),
        ],
      ),
    );
  }
}
