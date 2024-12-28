import 'package:task_manager/features/task/data/datasource/theme_datasource.dart';
import 'package:task_manager/features/task/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<bool> getThemePreference() async {
    return await localDataSource.getThemePreference();
  }

  @override
  Future<void> saveThemePreference(bool isDarkMode) async {
    await localDataSource.saveThemePreference(isDarkMode);
  }
}
