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
              padding: const EdgeInsets.symmetric(horizontal: 24),
              minimumSize: const Size(0, 48),
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
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            ColorConst.thirdColor,
            ColorConst.darkColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: ColorConst.thirdColor.withValues(alpha: 0.12),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -20,
            child: _GlowCircle(
              size: 160,
              color: ColorConst.primaryColor.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: _GlowCircle(
              size: 200,
              color: ColorConst.whiteColor.withValues(alpha: 0.08),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: ColorConst.whiteColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConst.whiteColor.withValues(alpha: 0.2),
                ),
              ),
              child: const Icon(
                Icons.terminal_rounded,
                color: ColorConst.whiteColor,
                size: 48,
              ),
            ),
          ),
          const Positioned(
            top: 24,
            left: 24,
            child: _SkillBadge(
              icon: Icons.code_rounded,
              label: 'Dart',
            ),
          ),
          const Positioned(
            top: 84,
            right: 24,
            child: _SkillBadge(
              icon: Icons.cloud_outlined,
              label: 'API',
            ),
          ),
          const Positioned(
            bottom: 24,
            right: 24,
            child: _SkillBadge(
              icon: Icons.phone_iphone_rounded,
              label: 'Flutter',
            ),
          ),
          const Positioned(
            bottom: 84,
            left: 24,
            child: _SkillBadge(
              icon: Icons.auto_awesome_rounded,
              label: 'UI',
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: CustomText(
                profile.profileTag,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 40,
                      letterSpacing: 1.2,
                      color: ColorConst.whiteColor.withValues(alpha: 0.75),
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

class _SkillBadge extends StatelessWidget {
  const _SkillBadge({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConst.secondColor.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: ColorConst.whiteColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: ColorConst.whiteColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          CustomText(
            label,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorConst.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
