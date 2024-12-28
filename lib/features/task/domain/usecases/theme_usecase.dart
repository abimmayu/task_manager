import 'package:task_manager/features/task/domain/repository/theme_repository.dart';

class ToggleThemeUseCase {
  final ThemeRepository repository;

  ToggleThemeUseCase(this.repository);

  Future<void> call(bool isDarkMode) async {
    await repository.saveThemePreference(isDarkMode);
  }
}
