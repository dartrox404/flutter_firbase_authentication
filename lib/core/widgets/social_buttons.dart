import 'package:flutter/material.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.secondary,
          borderRadius: BorderRadius.circular(AppSizes.kradiusMd),
        ),
        width: media.width * .25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/Google.svg', height: AppSizes.kiconXl),
            const Gap(AppSizes.kspace8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Login in with Google',
                style: theme.bodyLarge?.copyWith(
                  fontFamily: 'poppins',
                  color: color.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
