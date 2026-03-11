import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/widget/nav_item_widget.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConst.secondColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                Strings.navigationTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.sections
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: NavItemWidget(
                              controller: controller,
                              index: e.id,
                              label: e.title,
                              isDesktop: false,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
