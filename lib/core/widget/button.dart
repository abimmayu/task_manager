import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constant/color.dart';
import 'package:task_manager/core/utils/text_style.dart';

class ButtonFilled extends StatelessWidget {
  const ButtonFilled({
    super.key,
    required this.onTap,
    required this.hintText,
  });

  final Function() onTap;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(50.h),
        ),
        child: Center(
          child: Text(
            hintText,
            style: AppTextStyle.title.copyWith(color: AppColor.backgroundColor),
          ),
        ),
      ),
    );
  }
}
