import 'package:aaraadhya_temple_dashboard/core/extensions/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    this.fillColor,
    this.borderRadius,
    this.hint,
    this.obscureText,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign,
    this.fontsize,
    this.autofocus,
    this.maxLines,
    super.key,
  });

  final Color? fillColor;
  final double? borderRadius;
  final String? hint;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final double? fontsize;
  final bool? autofocus;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      style: context.theme.textTheme.bodyMedium?.copyWith(fontSize: fontsize),
      autofocus: autofocus ?? false,
      maxLines: obscureText == true ? 1 : maxLines,
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
    );
  }
}
