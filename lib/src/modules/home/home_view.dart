import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFebeae6),
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
          color: const Color(0xFFebeae6),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFF323639).withOpacity(0.12)),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'MyProfile',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF323639),
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
                        label: controller.sections[i],
                        isDesktop: isDesktop,
                      ),
                    ),
                  const SizedBox(width: 20),
                  Text(
                    'Our journal',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xFF323639).withOpacity(0.6),
                        ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFfa824c),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: const Text('Get started'),
                  ),
                ],
              )
            else
              IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: const Color(0xFFebeae6),
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
                                'Navigation',
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i < controller.sections.length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4),
                                      child: _NavItem(
                                        controller: controller,
                                        index: i,
                                        label: controller.sections[i],
                                        isDesktop: false,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  minimumSize:
                                      const Size.fromHeight(44),
                                ),
                                child: const Text('Get started'),
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
                  color: Color(0xFF323639),
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
      onEnter: isDesktop
          ? (_) => controller.setHoveredIndex(index)
          : null,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFfa824c).withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF323639),
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w400,
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
        Text('Hi, I\'m', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Text(
          'Your Name',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Flutter Developer • Mobile & Web',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: const Color(0xFFfa824c),
              ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'I build fast, responsive applications with Flutter and GetX. '
            'Clean architecture, smooth animations and pixel‑perfect UI.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _ContactPillButton(
              label: 'Contact',
              onTap: () => Get.find<HomeController>().onNavTap(4),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFfa824c)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.picture_as_pdf_outlined),
              label: const Text('Download CV'),
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
            Color(0xFF323639),
            Color(0xFF131516),
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
              'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    const Color(0xFF131516).withOpacity(0.92),
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
                '/PROFILE',
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
      title: 'About',
      child: Text(
        'I am a Flutter developer focused on building high‑quality mobile and web '
        'applications. I enjoy crafting clean UIs, managing state with GetX, and '
        'structuring apps using clean architecture principles.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _SkillsSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'Skills',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: controller.skills
            .map(
              (skill) => Chip(
                label: Text(skill),
                backgroundColor: const Color(0xFFebeae6),
                side: const BorderSide(color: Color(0xFF323639)),
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF323639),
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
      title: 'Projects',
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
                title: project['title']!,
                description: project['description']!,
              );
            },
          );
        },
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SectionContainer(
      title: 'Contact',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let\'s work together on your next project.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: const [
              _ContactItem(
                icon: Icons.mail_outline,
                label: 'your.email@example.com',
              ),
              _ContactItem(
                icon: Icons.link,
                label: 'your-portfolio-link.com',
              ),
              _ContactItem(
                icon: Icons.location_on_outlined,
                label: 'Your City, Country',
              ),
            ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF323639).withOpacity(0.1)),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF323639).withOpacity(0.1)),
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
                  'View details',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFFfa824c),
                      ),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: Color(0xFFfa824c),
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
        color: const Color(0xFFebeae6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF323639).withOpacity(0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF323639),
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
          color: const Color(0xFFfa824c),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 16),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFfa824c),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.south_east_rounded,
                size: 16,
                color: Color(0xFF323639),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

