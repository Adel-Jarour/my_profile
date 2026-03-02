import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          return Row(
            children: [
              if (isWide)
                _SideBar(
                  controller: controller,
                ),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isWide)
                        _TopBar(
                          controller: controller,
                        ),
                      const SizedBox(height: 32),
                      _HeroSection(isWide: isWide),
                      const SizedBox(height: 64),
                      _AboutSection(),
                      const SizedBox(height: 64),
                      _SkillsSection(),
                      const SizedBox(height: 64),
                      _ProjectsSection(),
                      const SizedBox(height: 64),
                      _ContactSection(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'MyProfile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Spacer(),
        Obx(
          () => Row(
            children: [
              for (var i = 0; i < controller.sections.length; i++)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _NavItem(
                    label: controller.sections[i],
                    selected: controller.currentSection.value == i,
                    onTap: () => controller.changeSection(i),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SideBar extends StatelessWidget {
  const _SideBar({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF020617),
        border: Border(
          right: BorderSide(
            color: Color(0xFF111827),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MyProfile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < controller.sections.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _NavItem(
                      label: controller.sections[i],
                      selected: controller.currentSection.value == i,
                      onTap: () => controller.changeSection(i),
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '© ${DateTime.now().year} My Name',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
        ),
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
                color: const Color(0xFF38BDF8),
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
            FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF38BDF8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              icon: const Icon(Icons.mail_outline),
              label: const Text('Contact Me'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF38BDF8)),
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
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: ClipOval(
        child: Image.network(
          'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
          fit: BoxFit.cover,
        ),
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
                backgroundColor: const Color(0xFF020617),
                side: const BorderSide(color: Color(0xFF1F2937)),
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
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
        color: const Color(0xFF020617),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF111827)),
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
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF111827)),
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
                        color: const Color(0xFF38BDF8),
                      ),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: Color(0xFF38BDF8),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF111827),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFF38BDF8),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

