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
            SizedBox(
              height: 48,
              child: CustomButton(
                label: Strings.downloadCv,
                onPressed: () => Get.find<HomeController>().launchCv(),
                icon: Icons.picture_as_pdf_outlined,
                outlined: true,
                borderColor: ColorConst.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                minimumSize: const Size(0, 48),
              ),
            ),
          ],
        ),
      ],
    );

    final codingVisual = Container(
      constraints: BoxConstraints(
        maxWidth: isWide ? 520 : double.infinity,
        minHeight: 260,
        maxHeight: isWide ? 360 : 320,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: ColorConst.whiteColor,
        border: Border.all(
          color: ColorConst.thirdColor.withValues(alpha: 0.08),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 26,
            left: 26,
            child: _CodeLine(width: 120),
          ),
          Positioned(
            top: 54,
            left: 26,
            child: _CodeLine(width: 90),
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: _CodeLine(width: 140),
          ),
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConst.secondColor,
                border: Border.all(
                  color: ColorConst.thirdColor.withValues(alpha: 0.15),
                ),
              ),
              child: const Icon(
                Icons.terminal_rounded,
                color: ColorConst.thirdColor,
                size: 42,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomText(
                profile.profileTag,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      letterSpacing: 1.2,
                      color: ColorConst.thirdColor.withValues(alpha: 0.7),
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
          codingVisual,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        codingVisual,
        const SizedBox(height: 32),
        content,
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 8,
      decoration: BoxDecoration(
        color: ColorConst.thirdColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
