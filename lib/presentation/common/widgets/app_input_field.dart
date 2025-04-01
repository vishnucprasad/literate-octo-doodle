import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    this.fillColor,
    this.borderRadius,
    this.hint,
    this.labelText,
    this.obscureText,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign,
    this.fontsize,
    this.fontFamily,
    this.autofocus,
    this.maxLines,
    this.controller,
    super.key,
  });

  final Color? fillColor;
  final double? borderRadius;
  final String? hint;
  final String? labelText;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final double? fontsize;
  final String? fontFamily;
  final bool? autofocus;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            child: Text(
              labelText!,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: context.colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textAlign: textAlign ?? TextAlign.start,
          style: context.theme.textTheme.bodyMedium?.copyWith(
            fontFamily: fontFamily,
            fontSize: fontsize,
          ),
          autofocus: autofocus ?? false,
          maxLines: obscureText == true ? 1 : maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.theme.textTheme.bodyMedium?.copyWith(
              color: context.colors.grey[900],
              fontSize: fontsize,
            ),
            errorMaxLines: 3,
            errorText: errorText,
            filled: true,
            fillColor: fillColor ?? context.colors.grey[100],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 14.0),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
