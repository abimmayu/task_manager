abstract class ThemeRepository {
  Future<bool> getThemePreference();
  Future<void> saveThemePreference(bool isDarkMode);
}
