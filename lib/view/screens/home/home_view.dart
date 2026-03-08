import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/about_section/about_section.dart';
import 'package:my_profile/view/screens/home/contact_section/contact_section.dart';
import 'package:my_profile/view/screens/home/hero_section/hero_section.dart';
import 'package:my_profile/view/screens/home/project_section/project_section.dart';
import 'package:my_profile/view/screens/home/skill_section/skill_section_widget.dart';
import 'package:my_profile/view/screens/home/widget/header_bar_widget.dart';
import 'package:my_profile/view/screens/home/widget/nav_item_widget.dart';
import 'package:my_profile/view/widget/custom_button.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isDesktop = maxWidth >= 1024;

        return Scaffold(
          backgroundColor: ColorConst.secondColor,
          drawer: isDesktop
              ? null
              : Drawer(
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
                                children: [
                                  for (var i = 0;
                                      i < controller.sections.length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6),
                                      child: NavItemWidget(
                                        controller: controller,
                                        index: i,
                                        label: controller.sections[i].title,
                                        isDesktop: false,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomButton(
                            label: Strings.getStarted,
                            onPressed: () {},
                            backgroundColor: ColorConst.primaryColor,
                            foregroundColor: ColorConst.whiteColor,
                            minimumSize: const Size.fromHeight(44),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderBarWidget(
                  controller: controller,
                  isDesktop: isDesktop,
                ),
                const SizedBox(height: 40),
                Container(
                  key: controller.sectionKeys[0],
                  child: HeroSection(isWide: isDesktop),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[1],
                  child: const AboutSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[2],
                  child: const SkillsSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[3],
                  child: const ProjectsSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[4],
                  child: const ContactSection(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}


