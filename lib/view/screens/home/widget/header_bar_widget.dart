import 'dart:ui';

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
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: ColorConst.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorConst.thirdColor.withValues(alpha: 0.15),
                  ),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: ColorConst.thirdColor,
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
                          padding: const EdgeInsetsDirectional.only(start: 8),
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
      ),
    );
  }
}
