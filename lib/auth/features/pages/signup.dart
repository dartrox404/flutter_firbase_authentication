import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/features/providers/auth_form_provider.dart';
import 'package:flutter_auth/auth/features/providers/auth_method_provider.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:flutter_auth/core/widgets/custom_textfeild.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
          title: Text('Signup Failed'),
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.kspace12),
          child: ListView(
            padding: EdgeInsets.only(top: AppSizes.kspace20),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/animations/Cat playing animation.json'),
                  Text(
                    'Lets Get Started',
                    style: theme.headlineLarge?.copyWith(
                      color: color.secondary,
                    ),
                  ),
                  const Gap(AppSizes.kspace12),
                  Text(
                    textAlign: TextAlign.center,
                    'To get started with first create account in oder to continue',
                    style: theme.bodyMedium?.copyWith(color: color.secondary),
                  ),
                  const Gap(AppSizes.kspace20),
                  CustomTextfeild(
                    obscureText: false,

                    labeltext: 'Name',
                    errortext: state.namerror,
                    prefixicon: LineIcons.user,
                    onChanged: (x) => notify.updateName(x),
                  ),
                  const Gap(AppSizes.kspace12),
                  CustomTextfeild(
                    obscureText: false,

                    labeltext: 'Email',
                    prefixicon: LineIcons.envelope,
                    onChanged: (x) => notify.updateEmail(x),
                    errortext: state.emailerror,
                  ),
                  const Gap(AppSizes.kspace12),
                  CustomTextfeild(
                    obscureText: state.ispasswordhidden,
                    onTap: () => notify.tooglepassword(),
                    labeltext: 'Password',
                    prefixicon: LineIcons.lock,
                    onChanged: (x) => notify.updatePassword(x),
                    errortext: state.passworderror,
                    sufficicon: state.ispasswordhidden
                        ? LineIcons.eye
                        : LineIcons.eyeSlash,
                  ),
                  const Gap(AppSizes.kspace20),
                  SizedBox(
                    width: media.width,
                    child: ElevatedButton(
                      onPressed: state.signupValidation ? signup : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.signupValidation
                              ? color.primary
                              : color.tertiary,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.kradiusSm,
                            ),
                          ),
                        ),
                      ),
                      child: state.isloading
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: color.surface,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Signup',
                                style: theme.bodyLarge?.copyWith(
                                  color: state.signupValidation
                                      ? color.surface
                                      : color.surface,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const Gap(AppSizes.kspace12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Already have an account',
                        style: theme.bodySmall?.copyWith(
                          color: color.secondary,
                        ),
                      ),
                      const Gap(5),
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: Text(
                          'login',
                          style: theme.bodySmall?.copyWith(
                            color: color.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
