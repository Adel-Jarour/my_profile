import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/about_section/about_section.dart';
import 'package:my_profile/view/screens/home/contact_section/contact_section.dart';
import 'package:my_profile/view/screens/home/hero_section/hero_section.dart';
import 'package:my_profile/view/screens/home/project_section/project_section.dart';
import 'package:my_profile/view/screens/home/skill_section/skill_section_widget.dart';
import 'package:my_profile/view/screens/home/widget/custom_drawer.dart';
import 'package:my_profile/view/screens/home/widget/header_bar_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isDesktop = maxWidth >= 1024;
        final horizontalPadding = isDesktop ? 32.0 : 20.0;
        final heroMinHeight = (MediaQuery.of(context).size.height - 120).clamp(0.0, double.infinity);

        return Scaffold(
          backgroundColor: ColorConst.secondColor,
          drawer: isDesktop ? null : CustomDrawer(),
          body: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: ColorConst.secondColor,
                elevation: 0,
                toolbarHeight: 88,
                titleSpacing: 0,
                title: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    12,
                  ),
                  child: HeaderBarWidget(
                    controller: controller,
                    isDesktop: isDesktop,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  12,
                  horizontalPadding,
                  40,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        key: controller.sectionKeys[0],
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: heroMinHeight),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: HeroSection(isWide: isDesktop),
                          ),
                        ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}

