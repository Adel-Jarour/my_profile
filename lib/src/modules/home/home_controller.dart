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

  void changeSection(int index) {
    currentSection.value = index;
    // In a real design, you might scroll to anchors here.
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

