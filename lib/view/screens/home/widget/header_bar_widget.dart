import 'package:flutter/material.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/widget/nav_item_widget.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class HeaderBarWidget extends StatelessWidget {
  const HeaderBarWidget({
    super.key,
    required this.controller,
    required this.isDesktop,
  });

  final HomeController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: ColorConst.secondColor.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: ColorConst.thirdColor.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConst.blackColor.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  ColorConst.primaryColor,
                  ColorConst.thirdColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.code_rounded,
              color: ColorConst.whiteColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          CustomText(
            Strings.logoTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorConst.thirdColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          if (isDesktop)
            Row(
              children: controller.sections
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: NavItemWidget(
                        controller: controller,
                        index: e.id,
                        label: e.title,
                        isDesktop: isDesktop,
                      ),
                    ),
                  )
                  .toList(),
            )
          else
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: Scaffold.of(context).openDrawer,
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: ColorConst.thirdColor,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
