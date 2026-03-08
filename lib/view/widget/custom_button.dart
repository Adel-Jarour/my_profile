import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.padding,
    this.minimumSize,
    this.borderRadius = 999,
    this.textStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool outlined;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final double borderRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final child = CustomText(
      label,
      style: textStyle,
    );

    if (outlined) {
      return icon == null
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                foregroundColor: foregroundColor,
                padding: padding,
                minimumSize: minimumSize,
                shape: RoundedRectangleBorder(borderRadius: radius),
              ),
              child: child,
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                foregroundColor: foregroundColor,
                padding: padding,
                minimumSize: minimumSize,
                shape: RoundedRectangleBorder(borderRadius: radius),
              ),
              label: child,
            );
    }

    return icon == null
        ? FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              padding: padding,
              minimumSize: minimumSize,
              shape: RoundedRectangleBorder(borderRadius: radius),
            ),
            child: child,
          )
        : FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            style: FilledButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              padding: padding,
              minimumSize: minimumSize,
              shape: RoundedRectangleBorder(borderRadius: radius),
            ),
            label: child,
          );
  }
}

