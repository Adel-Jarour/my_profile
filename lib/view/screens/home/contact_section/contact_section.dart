import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/contact_section/custom_contact_item.dart';
import 'package:my_profile/view/screens/home/widget/custom_section_container.dart';

class ContactSection extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
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
                  (contact) => CustomContactItem(
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
