import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/features/providers/auth_method_provider.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  Future<void> logout() async {
    final res = ref.read(authMethodProvider);
    await res.logout();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Iconsax.home,
          size: AppSizes.kiconXl,
          color: Theme.of(context).colorScheme.secondary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => logout(),
              child: Icon(
                Iconsax.logout,
                size: AppSizes.kiconXl,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontFamily: 'raleway',
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const Gap(AppSizes.kspace16),
            Icon(
              LineIcons.ethereum,
              size: AppSizes.kspace32,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
