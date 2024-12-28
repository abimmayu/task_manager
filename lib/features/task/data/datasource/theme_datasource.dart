import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/theme/theme_constans.dart';

abstract class ThemeLocalDataSource {
  Future<bool> getThemePreference();
  Future<void> saveThemePreference(bool isDarkMode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> getThemePreference() async {
    return sharedPreferences.getBool(kThemePreferenceKey) ?? false;
  }

  @override
  Future<void> saveThemePreference(bool isDarkMode) async {
    await sharedPreferences.setBool(kThemePreferenceKey, isDarkMode);
  }
}
