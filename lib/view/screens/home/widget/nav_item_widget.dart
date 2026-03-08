import 'package:flutter/material.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:get/get.dart';

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
            borderRadius: BorderRadius.circular(999),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              controller.onNavTap(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? ColorConst.primaryColor.withValues(alpha: 0.12)
                    : ColorConst.transparentColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
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
