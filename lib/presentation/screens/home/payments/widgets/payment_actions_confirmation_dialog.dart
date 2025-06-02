import 'package:aaraadhya_temple_dashboard/core/enums/booking_status.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_localizations_extension.dart';
import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:aaraadhya_temple_dashboard/presentation/controllers/home/payments/payments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentActionsConfirmationDialog extends ConsumerWidget {
  const PaymentActionsConfirmationDialog({
    super.key,
    required this.paymentIndex,
    required this.status,
  });

  final int paymentIndex;
  final BookingStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(paymentsControllerProvider.notifier);
    final state = ref.watch(paymentsControllerProvider);

    return AlertDialog(
      icon: CircleAvatar(
        backgroundColor: context.colorScheme.primary,
        child:
            state.isLoading
                ? SizedBox.square(
                  dimension: 24.0,
                  child: CircularProgressIndicator(
                    color: context.colorScheme.onPrimary,
                  ),
                )
                : Icon(Icons.question_mark, color: context.colors.white),
      ),
      iconPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
      title: Text(
        status == BookingStatus.confirmed
            ? context.l10n.approvePaymentConfirmationTitle
            : context.l10n.rejectPaymentConfirmationTitle,
        style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 0.0),
      content: Text(
        status == BookingStatus.confirmed
            ? context.l10n.approvePaymentConfirmationMessage
            : context.l10n.rejectPaymentConfirmationMessage,
        textAlign: TextAlign.center,
      ),
      actionsPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: context.colors.error),
          child: Text(context.l10n.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () async {
            if (status == BookingStatus.confirmed) {
              await controller.verifyPayment(
                paymentId: state.payments[paymentIndex].id,
              );
            }

            if (status == BookingStatus.rejected) {
              await controller.rejectPayment(
                paymentId: state.payments[paymentIndex].id,
              );
            }

            if (context.mounted) context.pop();
          },
          child: Text(
            status == BookingStatus.confirmed
                ? context.l10n.approvePaymentButtonLabel
                : context.l10n.rejectPaymentButtonLabel,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
