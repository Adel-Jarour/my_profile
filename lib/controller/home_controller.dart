import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/translation/strings_enum.dart';
import '../models/contacts_model.dart';
import '../models/profile_info_model.dart';
import '../models/projects_model.dart';
import '../models/sections_model.dart';
import '../models/skills_model.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final profileInfo = const ProfileInfoModel(
    name: 'Your Name',
    email: 'your.email@example.com',
    imageUrl:
        'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg',
    role: 'Flutter Developer - Mobile & Web',
    greeting: 'Hi, I\'m',
    heroDescription:
        'I build fast, responsive applications with Flutter and GetX. '
        'Clean architecture, smooth animations and pixel-perfect UI.',
    aboutDescription:
        'I am a Flutter developer focused on building high-quality mobile and web '
        'applications. I enjoy crafting clean UIs, managing state with GetX, and '
        'structuring apps using clean architecture principles.',
    profileTag: '/PROFILE',
    location: 'Your City, Country',
    portfolio: 'your-portfolio-link.com',
    cvUrl: 'https://example.com/your-cv.pdf',
  );

  final sections = const [
    SectionsModel(id: 0, title: Strings.navHome),
    SectionsModel(id: 1, title: Strings.navAbout),
    SectionsModel(id: 2, title: Strings.navSkills),
    SectionsModel(id: 3, title: Strings.navProjects),
    SectionsModel(id: 4, title: Strings.navContact),
  ];

  final skills = const [
    SkillsModel(id: 1, skill: Strings.skillFlutter),
    SkillsModel(id: 2, skill: Strings.skillDart),
    SkillsModel(id: 3, skill: Strings.skillGetx),
    SkillsModel(id: 4, skill: Strings.skillFirebase),
    SkillsModel(id: 5, skill: Strings.skillRestApis),
    SkillsModel(id: 6, skill: Strings.skillCleanArchitecture),
  ];

  final projects = const [
    ProjectsModel(
      id: 1,
      title: Strings.projectOneTitle,
      description: Strings.projectOneDescription,
    ),
    ProjectsModel(
      id: 2,
      title: Strings.projectTwoTitle,
      description: Strings.projectTwoDescription,
    ),
    ProjectsModel(
      id: 3,
      title: Strings.projectThreeTitle,
      description: Strings.projectThreeDescription,
    ),
  ];

  late final List<ContactsModel> contacts = [
    ContactsModel(id: 1, icon: Icons.mail_outline, label: profileInfo.email),
    ContactsModel(id: 2, icon: Icons.link, label: profileInfo.portfolio),
    ContactsModel(
      id: 3,
      icon: Icons.location_on_outlined,
      label: profileInfo.location,
    ),
  ];

  final currentSection = 0.obs;
  final hoveredIndex = (-1).obs;

  final List<GlobalKey> sectionKeys = [];

  @override
  void onInit() {
    super.onInit();
    sectionKeys.addAll(List.generate(sections.length, (_) => GlobalKey()));
    scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentSectionFromScroll();
    });
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

  void _onScroll() {
    _updateCurrentSectionFromScroll();
  }

  void _updateCurrentSectionFromScroll() {
    if (sectionKeys.isEmpty) return;

    const topThreshold = 140.0;
    var activeIndex = 0;

    for (var i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context == null) continue;
      final renderObject = context.findRenderObject();
      if (renderObject is! RenderBox) continue;

      final position = renderObject.localToGlobal(Offset.zero);
      if (position.dy <= topThreshold) {
        activeIndex = i;
      }
    }

    if (currentSection.value != activeIndex) {
      currentSection.value = activeIndex;
    }
  }

  Future<void> launchCv() async {
    final uri = Uri.parse(profileInfo.cvUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
  }

  void _scrollToSection(int index) {
    if (index < 0 || index >= sectionKeys.length) return;
    final context = sectionKeys[index].currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
}
