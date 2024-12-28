import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constant/color.dart';
import 'package:task_manager/core/utils/text_style.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String dueDate;
  final String status;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomMiddleClipper(),
      child: Container(
        padding: EdgeInsets.all(50.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            50.w,
          ),
          color: AppColor.primaryColor,
        ),
        width: double.infinity,
        height: 400.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.title.copyWith(
                    color: AppColor.backgroundColor,
                  ),
                ),
                Text(
                  dueDate,
                  style: AppTextStyle.subtitle.copyWith(
                    color: AppColor.backgroundColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: AppTextStyle.subtitle.copyWith(
                    color: AppColor.backgroundColor,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onEdit,
                      icon: const Icon(
                        Icons.edit,
                        color: AppColor.accentColor,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        color: AppColor.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMiddleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2 - 20, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 20, size.width / 2 + 20, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
