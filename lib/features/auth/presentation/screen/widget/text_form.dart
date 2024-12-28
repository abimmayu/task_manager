import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.prefixIcon,
    required this.controller,
    required this.hintText,
    this.obsecureStatus,
    this.onVisibility,
  });
  final IconData prefixIcon;
  final TextEditingController controller;
  final String hintText;
  final bool? obsecureStatus;
  final Function()? onVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureStatus != null ? obsecureStatus! : false,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        suffixIcon: obsecureStatus != null
            ? obsecureStatus == true
                ? InkWell(
                    onTap: onVisibility,
                    child: const Icon(
                      Icons.visibility,
                    ),
                  )
                : InkWell(
                    onTap: onVisibility,
                    child: const Icon(
                      Icons.visibility_off,
                    ),
                  )
            : null,
      ),
    );
  }
}
