import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task/domain/usecases/theme_usecase.dart';

class ThemeCubit extends Cubit<bool> {
  final ToggleThemeUseCase toggleThemeUseCase;

  ThemeCubit(this.toggleThemeUseCase) : super(false);

  void toggleTheme(bool isDarkMode) async {
    await toggleThemeUseCase(isDarkMode);
    emit(isDarkMode);
  }
}
