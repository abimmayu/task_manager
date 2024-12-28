import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/core/constant/color.dart';

class AppTextStyle {
  static final _fontFamily = GoogleFonts.roboto().fontFamily;

  static TextStyle _baseStyle({
    required BuildContext context,
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color:
          Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.primaryColor,
    );
  }

  static TextStyle title(BuildContext context) => _baseStyle(
        context: context,
        fontWeight: FontWeight.w700,
        fontSize: 48.sp,
      );

  static TextStyle body(BuildContext context) => _baseStyle(
        context: context,
        fontSize: 24.sp,
      );

  static TextStyle tinyText(BuildContext context) => _baseStyle(
        context: context,
        fontSize: 20.sp,
      );

  static TextStyle subtitle(BuildContext context) => _baseStyle(
        context: context,
        fontWeight: FontWeight.w500,
        fontSize: 42.sp,
      );

  static TextStyle description(BuildContext context) => _baseStyle(
        context: context,
        fontSize: 24.sp,
      );
}
