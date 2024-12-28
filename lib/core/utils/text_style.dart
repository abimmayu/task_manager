import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/core/constant/color.dart';

class AppTextStyle {
  static final _fontFamily = GoogleFonts.roboto().fontFamily;

  static TextStyle _baseStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: AppColor.primaryTextColor,
    );
  }

  static final title = _baseStyle(
    fontWeight: FontWeight.w700,
    fontSize: 48.sp,
  );

  static final body = _baseStyle(
    fontSize: 24.sp,
  );

  static final tinyText = _baseStyle(
    fontSize: 20.sp,
  );

  static final subtitle = _baseStyle(
    fontWeight: FontWeight.w500,
    fontSize: 42.sp,
  );

  static final description = _baseStyle(
    fontSize: 24.sp,
  );
}
