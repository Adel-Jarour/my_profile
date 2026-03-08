import 'package:flutter/material.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class CustomProjectCard extends StatelessWidget {
  const CustomProjectCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.1)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomText(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  Strings.viewDetails,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConst.primaryColor,
                      ),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: ColorConst.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

