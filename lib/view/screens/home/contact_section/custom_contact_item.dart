import 'package:flutter/material.dart';
import 'package:my_profile/const/color_const.dart';

class CustomContactItem extends StatelessWidget {
  const CustomContactItem({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConst.secondColor,
        borderRadius: BorderRadius.circular(999),
        border:
            Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: ColorConst.thirdColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
