import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constant/color.dart';
import 'package:task_manager/core/utils/text_style.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 150.h,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(50.h),
        ),
        child: Center(
          child: Text(
            '',
            style: AppTextStyle.title(
              context,
            ).copyWith(
              color: AppColor.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
