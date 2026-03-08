import 'package:flutter/material.dart';
import 'package:my_profile/const/color_const.dart';

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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
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
