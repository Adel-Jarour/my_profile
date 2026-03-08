import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/widget/custom_section_container.dart';

class SkillsSection extends GetView<HomeController> {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      title: Strings.navSkills,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: controller.skills
            .map(
              (skill) => Chip(
                label: Text(skill.skill),
                backgroundColor: ColorConst.secondColor,
                side: const BorderSide(color: ColorConst.thirdColor),
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorConst.thirdColor,
                    ),
              ),
            )
            .toList(),
      ),
    );
  }
}
