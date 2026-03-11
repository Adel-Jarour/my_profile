import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class NavItemWidget extends StatelessWidget {
  const NavItemWidget({
    super.key,
    required this.controller,
    required this.index,
    required this.label,
    required this.isDesktop,
  });

  final HomeController controller;
  final int index;
  final String label;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: isDesktop ? (_) => controller.setHoveredIndex(index) : null,
      onExit: isDesktop ? (_) => controller.clearHoveredIndex() : null,
      child: Obx(
        () {
          final selected = controller.currentSection.value == index;
          final hovered = controller.hoveredIndex.value == index;
          final isActive = selected || hovered;

          return InkWell(
            onTap: () {
              if (!isDesktop && Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              controller.onNavTap(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive
                        ? ColorConst.primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: CustomText(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConst.thirdColor,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
