import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/gen/fonts.gen.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_input_field.dart';
import 'package:aaraadhya_temple_dashboard/presentation/common/widgets/app_spacing.dart';
import 'package:aaraadhya_temple_dashboard/presentation/screens/registrations/view_registrations/widgets/registration_details_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListofRegistrations extends StatelessWidget {
  const ListofRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        AppSpacing.verticalSmall,
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.colors.grey[50],
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mahanavami Pooja',
                style: context.theme.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.verticalSmall,
              Text(
                DateFormat("MMMM d, y • h:mm a").format(DateTime.now()),
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
              ),
              AppSpacing.verticalSmall,
              Text(
                'Main Temple • ${context.l10n.registrationsCount(43)}',
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: FontFamily.roboto,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.verticalSmall,
        AppInputField(
          hint: context.l10n.searchLabel,
          prefixIcon: Icon(Icons.search, color: context.colors.grey[700]),
        ),
        AppSpacing.verticalMedium,
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return RegistrationDetailsCard(index: index);
          },
          separatorBuilder: (context, index) => AppSpacing.verticalMedium,
        ),
        AppSpacing.verticalMedium,
      ],
    );
  }
}
