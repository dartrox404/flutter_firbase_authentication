import 'package:flutter/material.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';

class CustomTextfeild extends StatelessWidget {
  const CustomTextfeild({
    super.key,
    this.errortext,
    required this.hinttext,
    this.prefixicon,
    this.sufficicon,
    this.onChanged,
    this.onTap,
    required this.obscureText,
  });
  final String? errortext;
  final String hinttext;
  final IconData? prefixicon;
  final IconData? sufficicon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final theme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context).size;

    return SizedBox(
      width: media.width * .25,
      child: TextField(
        cursorColor: color.secondary.withValues(alpha: .3),
        obscureText: obscureText,
        style: theme.bodyMedium?.copyWith(
          color: color.secondary,
          fontFamily: 'poppins',
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.kradiusMd),
          ),
          filled: true,
          fillColor: color.tertiary.withValues(alpha: .2),
          hintText: hinttext,
          hintStyle: theme.bodyMedium?.copyWith(
            color: color.tertiary,
            fontFamily: 'poppins',
          ),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(sufficicon, color: color.secondary),
          ),
          prefixIcon: Icon(
            prefixicon,
            color: color.secondary.withValues(alpha: .3),
          ),
          errorText: errortext,
          errorStyle: theme.bodyMedium?.copyWith(color: Colors.red),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(AppSizes.kradiusSm),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(AppSizes.kradiusSm),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color.secondary.withValues(alpha: .3),
            ),
            borderRadius: BorderRadius.circular(AppSizes.kradiusSm),
          ),
        ),
      ),
    );
  }
}
