import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final sections = const [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Contact',
  ];

  final currentSection = 0.obs;
  final hoveredIndex = (-1).obs;

  /// Keys for scrolling to each section.
  final List<GlobalKey> sectionKeys = [];

  final skills = const [
    'Flutter',
    'Dart',
    'GetX',
    'Firebase',
    'REST APIs',
    'Clean Architecture',
  ];

  final projects = const [
    {
      'title': 'Project One',
      'description':
          'Modern responsive web app built with Flutter for web and GetX.',
    },
    {
      'title': 'Project Two',
      'description':
          'Cross‑platform mobile application with real‑time updates and clean UI.',
    },
    {
      'title': 'Project Three',
      'description':
          'Dashboard with charts, analytics and smooth animations.',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    sectionKeys.addAll(List.generate(sections.length, (_) => GlobalKey()));
  }

  void onNavTap(int index) {
    currentSection.value = index;
    _scrollToSection(index);
  }

  void setHoveredIndex(int index) {
    hoveredIndex.value = index;
  }

  void clearHoveredIndex() {
    hoveredIndex.value = -1;
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= sectionKeys.length) return;
    final context = sectionKeys[index].currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.1,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

