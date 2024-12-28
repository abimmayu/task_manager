import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/theme/theme_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return SwitchListTile(
              title: Text(isDarkMode ? 'Mode Gelap' : 'Mode Terang'),
              value: isDarkMode,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme(value);
              },
            );
          },
        ),
      ),
    );
  }
}
