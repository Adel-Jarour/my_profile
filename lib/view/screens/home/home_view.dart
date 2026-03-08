import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/translation/strings_enum.dart';
import '../../../const/color_const.dart';
import '../../../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.secondColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final isDesktop = maxWidth >= 1024;

          return SingleChildScrollView(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderBar(
                  controller: controller,
                  isDesktop: isDesktop,
                ),
                const SizedBox(height: 40),
                Container(
                  key: controller.sectionKeys[0],
                  child: _HeroSection(isWide: isDesktop),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[1],
                  child: _AboutSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[2],
                  child: _SkillsSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[3],
                  child: _ProjectsSection(),
                ),
                const SizedBox(height: 80),
                Container(
                  key: controller.sectionKeys[4],
                  child: _ContactSection(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({
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
            Text(
              Strings.logoTitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorConst.thirdColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            if (isDesktop)
              Row(
                children: [
                  for (var i = 0; i < controller.sections.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: _NavItem(
                        controller: controller,
                        index: i,
                        label: controller.sections[i].title,
                        isDesktop: isDesktop,
                      ),
                    ),
                  const SizedBox(width: 20),
                  Text(
                    Strings.journalLabel,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorConst.thirdColor.withValues(alpha: 0.6),
                        ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: ColorConst.primaryColor,
                      foregroundColor: ColorConst.whiteColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: const Text(Strings.getStarted),
                  ),
                ],
              )
            else
              IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: ColorConst.secondColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (context) {
                      return SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.navigationTitle,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < controller.sections.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: _NavItem(
                                        controller: controller,
                                        index: i,
                                        label: controller.sections[i].title,
                                        isDesktop: false,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: ColorConst.whiteColor,
                                  foregroundColor: ColorConst.blackColor,
                                  minimumSize: const Size.fromHeight(44),
                                ),
                                child: const Text(Strings.getStarted),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.menu_rounded,
                  color: ColorConst.thirdColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
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

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.heroGreeting, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Text(
          Strings.heroName,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 12),
        Text(
          Strings.heroRole,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorConst.primaryColor,
              ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            Strings.heroDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _ContactPillButton(
              label: Strings.navContact,
              onTap: () => Get.find<HomeController>().onNavTap(4),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: ColorConst.primaryColor),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text(Strings.downloadCv),
            ),
          ],
        ),
      ],
    );

    final avatar = Container(
      constraints: BoxConstraints(
        maxWidth: isWide ? 520 : double.infinity,
        minHeight: 260,
        maxHeight: isWide ? 360 : 320,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            ColorConst.thirdColor,
            ColorConst.darkColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              Strings.heroImageUrl,
              fit: BoxFit.cover,
              color: ColorConst.blackColor.withValues(alpha: 0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorConst.transparentColor,
                    ColorConst.darkColor.withValues(alpha: 0.92),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                Strings.heroProfileTag,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 54,
                      letterSpacing: 2,
                    ),
              ),
            ),
          ),
        ],
      ),
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: content),
          const SizedBox(width: 40),
          avatar,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: avatar),
        const SizedBox(height: 32),
        content,
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: Strings.navAbout,
      child: Text(
        Strings.aboutDescription,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _SkillsSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
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

class _ProjectsSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
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
              return _ProjectCard(
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

class _ContactSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: Strings.navContact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.contactCta,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: controller.contacts
                .map(
                  (contact) => _ContactItem(
                    icon: contact.icon,
                    label: contact.label,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  const _SectionContainer({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorConst.whiteColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: ColorConst.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.1)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.viewDetails,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConst.primaryColor,
                      ),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: ColorConst.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConst.secondColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ColorConst.thirdColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: ColorConst.thirdColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ContactPillButton extends StatelessWidget {
  const _ContactPillButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: ColorConst.primaryColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorConst.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: ColorConst.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConst.primaryColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.south_east_rounded,
                size: 16,
                color: ColorConst.thirdColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
