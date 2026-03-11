import 'package:flutter/material.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/widget/nav_item_widget.dart';
import 'package:my_profile/view/widget/custom_button.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: ColorConst.secondColor,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: ColorConst.thirdColor.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: ColorConst.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
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
      ),
    );
  }
}
