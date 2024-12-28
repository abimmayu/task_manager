import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constant/color.dart';
import 'package:task_manager/features/task/presentation/bloc/theme/theme_bloc.dart';
import 'package:task_manager/features/task/presentation/screen/widget/bottom_nav_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(50.w),
        child: Center(
          child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return SwitchListTile(
                title: Text(isDarkMode ? 'Mode Gelap' : 'Mode Terang'),
                value: isDarkMode,
                activeColor: AppColor.primaryColor,
                inactiveTrackColor: AppColor.secondaryColor,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme(value);
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        selectedIndex: 2,
      ),
    );
  }
}
