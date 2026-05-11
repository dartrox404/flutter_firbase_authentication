import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/features/providers/auth_controller_provider.dart';
import 'package:flutter_auth/auth/features/providers/auth_form_provider.dart';
import 'package:flutter_auth/auth/features/providers/auth_method_provider.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';
import 'package:flutter_auth/core/widgets/custom_textfeild.dart';
import 'package:flutter_auth/core/widgets/option_row.dart';
import 'package:flutter_auth/core/widgets/social_buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  Future<void> login() async {
    final state = ref.read(authLoginNotify);
    final notify = ref.read(authLoginNotify.notifier);
    final auth = ref.read(authMethodProvider);
    notify.setloading(true);
    try {
      final res = await auth.login(
        email: state.email,
        password: state.password,
      );
      if (!mounted) return;
      notify.setloading(false);
      if (res == "true") {
        toastification.show(
          title: Text('Login Successfull'),
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 3),
        );
        context.go('/home');
      } else {
        toastification.show(
          title: Text('Login Failed'),
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          alignment: Alignment.topLeft,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      notify.setloading(false);
      toastification.show(
        title: Text('Login Failed'),
        description: Text('UnExptected error occur'),
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> forgetemail(String a) async {
    final email = ref.read(authControllerProvider.notifier);
    try {
      await email.forgetpassword(a);
      toastification.show(
        title: Text('Email Verification Code Send'),
        description: Text('Please Check Your Inbox'),
        type: ToastificationType.info,
        style: ToastificationStyle.fillColored,
        alignment: Alignment.topLeft,
        autoCloseDuration: const Duration(seconds: 3),
      );
    } catch (e) {
      toastification.show(
        title: Text(e.toString()),
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
    final state = ref.watch(authLoginNotify);
    final notify = ref.read(authLoginNotify.notifier);
    final isloading = ref.watch(authControllerProvider);
    final google = ref.read(authControllerProvider.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Center(
        child: Container(
          width: media.width * .7,
          height: media.height * .8,
          decoration: BoxDecoration(
            color: color.surface,
            boxShadow: [
              BoxShadow(
                color: color.primary.withValues(alpha: .5),
                blurRadius: 20,
                spreadRadius: 1,
                offset: Offset(0, 8),
              ),
            ],
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
                    colors: [
                      Color(0xff0f0c29),
                      Color(0xff302b63),
                      Color(0xff24243e),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.kradiusMd),
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/Email motion loading.json',
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
                    'Welcome to University LMS',
                    style: theme.headlineLarge?.copyWith(fontFamily: 'poppins'),
                  ),
                  const Gap(AppSizes.kspace5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account yet?',
                        style: theme.titleSmall?.copyWith(
                          fontFamily: 'raleway',
                          color: color.tertiary,
                        ),
                      ),
                      const Gap(AppSizes.kspace5),
                      GestureDetector(
                        onTap: () => context.go('/signup'),
                        child: Text(
                          'Get Started',
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
                    prefixicon: Iconsax.lock,
                  ),
                  const Gap(AppSizes.kspace16),
                  GestureDetector(
                    onTap: () => forgetemail(state.email),
                    child: Text(
                      "Forget Password",
                      style: theme.titleSmall?.copyWith(
                        fontFamily: 'manrope',
                        fontWeight: FontWeight.bold,
                        color: color.secondary,
                      ),
                    ),
                  ),
                  const Gap(AppSizes.kspace12),
                  SizedBox(
                    width: media.width * .25,
                    child: ElevatedButton(
                      onPressed: state.loginValidation ? login : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.loginValidation
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
                                'Login',
                                style: theme.bodyMedium?.copyWith(
                                  fontFamily: 'manrope',
                                  color: state.loginValidation
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
