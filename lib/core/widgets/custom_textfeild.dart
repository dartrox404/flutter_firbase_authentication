import 'package:flutter/material.dart';
import 'package:flutter_auth/core/const/app_sizes.dart';

class CustomTextfeild extends StatelessWidget {
  const CustomTextfeild({
    super.key,
    this.errortext,
    required this.labeltext,
    this.prefixicon,
    this.sufficicon,
    this.onChanged,
    this.onTap,
    required this.obscureText,
  });
  final String? errortext;
  final String labeltext;
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
      width: media.width,
      child: TextField(
        obscureText: obscureText,
        style: theme.bodyMedium?.copyWith(color: color.secondary),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: theme.bodyMedium?.copyWith(color: color.secondary),
          suffixIcon: GestureDetector(
            onTap: onTap,
            child: Icon(sufficicon, color: color.secondary),
          ),
          prefixIcon: Icon(prefixicon, color: color.secondary),
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
            borderSide: BorderSide(color: color.primary),
            borderRadius: BorderRadius.circular(AppSizes.kradiusSm),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color.secondary),
            borderRadius: BorderRadius.circular(AppSizes.kradiusSm),
          ),
        ),
      ),
    );
  }
}
