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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context).size;
    final state = ref.watch(authLoginNotify);
    final notify = ref.read(authLoginNotify.notifier);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.kspace12),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/animations/Loader cat.json'),
                  Text(
                    'login To Account',
                    style: theme.headlineLarge?.copyWith(
                      color: color.secondary,
                    ),
                  ),
                  const Gap(AppSizes.kspace12),
                  Text(
                    textAlign: TextAlign.center,
                    'Enter your email and password to login to account',
                    style: theme.bodyMedium?.copyWith(color: color.secondary),
                  ),
                  const Gap(AppSizes.kspace20),
                  CustomTextfeild(
                    obscureText: false,

                    labeltext: 'Email',
                    prefixicon: LineIcons.envelope,
                    errortext: state.emailerror,
                    onChanged: (p) => notify.updateEmail(p),
                  ),
                  const Gap(AppSizes.kspace12),
                  CustomTextfeild(
                    obscureText: state.ispasswordhidden,
                    labeltext: 'Password',
                    prefixicon: LineIcons.lock,
                    errortext: state.passworderror,
                    onTap: () => notify.tooglepassword(),
                    sufficicon: state.ispasswordhidden
                        ? LineIcons.eye
                        : LineIcons.eyeSlash,
                    onChanged: (p) => notify.updatePassword(p),
                  ),
                  const Gap(AppSizes.kspace20),
                  SizedBox(
                    width: media.width,
                    child: ElevatedButton(
                      onPressed: state.loginValidation ? login : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.loginValidation
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
                          ? CircularProgressIndicator(strokeWidth: 2)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Login',
                                style: theme.bodyLarge?.copyWith(
                                  color: color.surface,
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
                        'Don\'t have an account',
                        style: theme.bodySmall?.copyWith(
                          color: color.secondary,
                        ),
                      ),
                      const Gap(5),
                      GestureDetector(
                        onTap: () => context.go('/signup'),
                        child: Text(
                          'Signup',
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
