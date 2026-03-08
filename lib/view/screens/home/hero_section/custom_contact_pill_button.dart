import 'package:flutter/material.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class CustomContactPillButton extends StatelessWidget {
  const CustomContactPillButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: ColorConst.primaryColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            CustomText(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorConst.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorConst.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConst.primaryColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.south_east_rounded,
                size: 16,
                color: ColorConst.thirdColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

