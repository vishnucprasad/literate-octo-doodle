import 'package:flutter/material.dart';

class RupeeIcon extends StatelessWidget {
  const RupeeIcon({
    super.key,
    required this.borderColor,
    required this.backgroundColor,
    required this.iconColor,
  });

  final Color borderColor;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 10,
        backgroundColor: backgroundColor,
        child: Icon(Icons.currency_rupee_outlined, size: 16, color: iconColor),
      ),
    );
  }
}
