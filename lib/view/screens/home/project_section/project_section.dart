import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/project_section/custom_project_card.dart';
import 'package:my_profile/view/screens/home/widget/custom_section_container.dart';

class ProjectsSection extends GetView<HomeController> {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      title: Strings.navProjects,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth > 1000
              ? 3
              : constraints.maxWidth > 700
                  ? 2
                  : 1;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 4 / 3,
            ),
            itemCount: controller.projects.length,
            itemBuilder: (context, index) {
              final project = controller.projects[index];
              return CustomProjectCard(
                title: project.title,
                description: project.description,
              );
            },
          );
        },
      ),
    );
  }
}
