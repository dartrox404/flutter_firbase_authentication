import 'package:flutter/material.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:gap/gap.dart';

class OptionRow extends StatelessWidget {
  const OptionRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: media.width * .1,
          child: Divider(color: color.tertiary),
        ),
        const Gap(AppSizes.kspace5),
        Text(
          'OR',
          style: theme.bodyMedium?.copyWith(
            fontFamily: 'poppins',
            color: color.tertiary,
          ),
        ),
        const Gap(AppSizes.kspace5),
        SizedBox(
          width: media.width * .1,
          child: Divider(color: color.tertiary),
        ),
      ],
    );
  }
}
