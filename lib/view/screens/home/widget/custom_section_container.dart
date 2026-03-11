import 'package:flutter/material.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class CustomSectionContainer extends StatelessWidget {
  const CustomSectionContainer({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorConst.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorConst.thirdColor.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
