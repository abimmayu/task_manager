import 'package:flutter/material.dart';
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
    fontSize: 24,
  );

  static final body = _baseStyle(
    fontSize: 16,
  );

  static final tinyText = _baseStyle(
    fontSize: 12,
  );

  static final subtitle = _baseStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static final description = _baseStyle(
    fontSize: 14,
  );
}
