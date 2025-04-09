import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/custom_painters/dotted_border_painter.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/profile/poojas/poojas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoojaImagePicker extends ConsumerWidget {
  const PoojaImagePicker({this.errorText, super.key});

  final String? errorText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(poojasControllerProvider);
    final controller = ref.read(poojasControllerProvider.notifier);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.colors.grey[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.poojaImageLabel,
            style: context.theme.textTheme.bodyMedium,
          ),
          AppSpacing.verticalMedium,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.grey[100],
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.grey,
                        image:
                            state.poojaImage != null
                                ? DecorationImage(
                                  image: MemoryImage(state.poojaImage!.bytes),
                                  fit: BoxFit.cover,
                                )
                                : null,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child:
                          state.poojaImage == null
                              ? Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 48,
                                ),
                              )
                              : null,
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalMedium,
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: GestureDetector(
                    onTap: controller.pickPoojaImage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: CustomPaint(
                        painter: DottedBorderPainter(
                          color: context.colors.grey,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30.0,
                                backgroundColor: context.colors.primary[50],
                                child: Icon(
                                  Icons.upload_outlined,
                                  size: 36.0,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              AppSpacing.verticalSmall,
                              Text(
                                context.l10n.selectPoojaImageLabel,
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
              ),
              AppSpacing.horizontalSmall,
            ],
          ),
          if (errorText != null) ...[
            AppSpacing.verticalSmall,
            Text(
              errorText!,
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
