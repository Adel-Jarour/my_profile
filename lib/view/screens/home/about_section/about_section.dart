import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/widget/custom_section_container.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class AboutSection extends GetView<HomeController> {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      title: Strings.navAbout,
      child: CustomText(
        controller.profileInfo.aboutDescription,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

