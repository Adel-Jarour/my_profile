import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_profile/config/translation/strings_enum.dart';
import 'package:my_profile/const/color_const.dart';
import 'package:my_profile/controller/home_controller.dart';
import 'package:my_profile/view/screens/home/hero_section/custom_contact_pill_button.dart';
import 'package:my_profile/view/widget/custom_button.dart';
import 'package:my_profile/view/widget/custom_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<HomeController>().profileInfo;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          profile.greeting,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        CustomText(
          profile.name,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 12),
        CustomText(
          profile.role,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ColorConst.primaryColor,
              ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: CustomText(
            profile.heroDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            CustomContactPillButton(
              label: Strings.navContact,
              onTap: () => Get.find<HomeController>().onNavTap(4),
            ),
            CustomButton(
              label: Strings.downloadCv,
              onPressed: () {},
              icon: Icons.picture_as_pdf_outlined,
              outlined: true,
              borderColor: ColorConst.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
              profile.imageUrl,
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
              child: CustomText(
                profile.profileTag,
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

