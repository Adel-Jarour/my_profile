import 'package:flutter/material.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/view/screens/home/widget/custom_section_container.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      title: Strings.navAbout,
      child: Text(
        Strings.aboutDescription,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
