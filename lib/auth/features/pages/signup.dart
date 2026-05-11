import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/features/providers/auth_controller_provider.dart';
import 'package:flutter_auth/auth/features/providers/auth_form_provider.dart';
import 'package:flutter_auth/auth/features/providers/auth_method_provider.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:flutter_auth/core/widgets/custom_textfeild.dart';
import 'package:flutter_auth/core/widgets/option_row.dart';
import 'package:flutter_auth/core/widgets/social_buttons.dart'
    show SocialButtons;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Signup> {
  Future<void> signup() async {
    final state = ref.read(authSignupNotify);
    final notify = ref.read(authSignupNotify.notifier);
    final auth = ref.read(authMethodProvider);
    notify.setloading(true);
    try {
      final res = await auth.signup(
        name: state.name,
        email: state.email,
        password: state.password,
      );
      if (!mounted) return;
      notify.setloading(false);
      if (res == "success") {
        toastification.show(
          title: Text('Signup Successfull'),
          description: Text("Please return to loginPage"),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 3),
        );
        context.go('/login');
      } else {
        toastification.show(
          title: Text(
            'Signup Failed',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontFamily: 'poppins',
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      notify.setloading(false);
      toastification.show(
        title: Text('Signup Failed'),
        description: Text('UnExptected error occur'),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context).size;
    final state = ref.watch(authSignupNotify);
    final notify = ref.read(authSignupNotify.notifier);
    final isloading = ref.watch(authControllerProvider);
    final google = ref.read(authControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Container(
          width: media.width * .7,
          height: media.height * .8,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color.primary.withValues(alpha: .5),
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, 8),
              ),
            ],
            color: color.surface,
            borderRadius: BorderRadius.circular(AppSizes.kradiusLg),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(AppSizes.kspace10),
              Container(
                height: media.height * .75,
                width: media.width * .35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff152331), Color(0xff000000)],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.kradiusMd),
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/Fireworks.json',
                    height: 350,
                  ),
                ),
              ),
              const Gap(AppSizes.kspace32),
              const Gap(AppSizes.kspace32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LineIcons.ethereum, color: color.secondary, size: 50),
                  const Gap(AppSizes.kspace5),
                  Text(
                    'Create An Account',
                    style: theme.headlineLarge?.copyWith(fontFamily: 'poppins'),
                  ),
                  const Gap(AppSizes.kspace5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: theme.titleSmall?.copyWith(
                          fontFamily: 'raleway',
                          color: color.tertiary,
                        ),
                      ),
                      const Gap(AppSizes.kspace5),
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: Text(
                          'Login',
                          style: theme.titleSmall?.copyWith(
                            fontFamily: 'raleway',
                            fontWeight: FontWeight.bold,
                            color: color.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSizes.kspace16),
                  CustomTextfeild(
                    errortext: state.namerror,
                    onChanged: (p) => notify.updateName(p),
                    hinttext: 'Input Name',
                    obscureText: false,
                    prefixicon: Iconsax.user,
                  ),
                  const Gap(AppSizes.kspace10),
                  CustomTextfeild(
                    errortext: state.emailerror,
                    onChanged: (p) => notify.updateEmail(p),
                    hinttext: 'Input Email',
                    obscureText: false,
                    prefixicon: Iconsax.sms,
                  ),
                  const Gap(AppSizes.kspace10),
                  CustomTextfeild(
                    errortext: state.passworderror,
                    onChanged: (p) => notify.updatePassword(p),
                    hinttext: 'Input Passsword',
                    obscureText: false,
                    prefixicon: Iconsax.password_check,
                  ),
                  const Gap(AppSizes.kspace16),
                  SizedBox(
                    width: media.width * .25,
                    child: ElevatedButton(
                      onPressed: state.signupValidation ? signup : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.signupValidation
                              ? color.secondary
                              : color.tertiary.withValues(alpha: .3),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.kradiusMd,
                            ),
                          ),
                        ),
                      ),
                      child: state.isloading
                          ? Lottie.asset(
                              'assets/animations/Loading 40 _ Paperplane.json',
                              height: 55,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Create Account',
                                style: theme.bodyMedium?.copyWith(
                                  fontFamily: 'manrope',
                                  color: state.signupValidation
                                      ? color.surface
                                      : color.tertiary,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const Gap(AppSizes.kspace12),
                  OptionRow(),
                  const Gap(AppSizes.kspace12),
                  isloading
                      ? CircularProgressIndicator()
                      : SocialButtons(onTap: () => google.loginin()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
