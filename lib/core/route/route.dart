import 'package:go_router/go_router.dart';
import 'package:task_manager/features/auth/presentation/screen/login_screen.dart';
import 'package:task_manager/features/auth/presentation/screen/register_screen.dart';
import 'package:task_manager/features/auth/presentation/screen/splash_screen.dart';
import 'package:task_manager/features/task/presentation/screen/create_task_screen.dart';
import 'package:task_manager/features/task/presentation/screen/edit_task_screen.dart';
import 'package:task_manager/features/task/presentation/screen/home_screen.dart';
import 'package:task_manager/features/task/presentation/screen/settings.screen.dart';

enum AppRoute {
  splashScreen,
  loginScreen,
  registerScreen,
  homeScreen,
  createTaskScreen,
  editTaskScreen,
  settingScreen,
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.splashScreen.name,
      builder: (context, state) {
        return const SplashScreen();
      },
      routes: [
        GoRoute(
          path: '/login',
          name: AppRoute.loginScreen.name,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        GoRoute(
          path: '/register',
          name: AppRoute.registerScreen.name,
          builder: (context, state) {
            return const RegisterScreen();
          },
        ),
        GoRoute(
          path: '/home',
          name: AppRoute.homeScreen.name,
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              path: '/add-task',
              name: AppRoute.createTaskScreen.name,
              builder: (context, state) {
                return const CreateTaskScreen();
              },
            ),
            GoRoute(
              path: '/edit-task',
              name: AppRoute.editTaskScreen.name,
              builder: (context, state) {
                final param = state.extra as EditTaskParam;
                return EditTaskScreen(
                  param: param,
                );
              },
            ),
            GoRoute(
              path: "/settings",
              name: AppRoute.settingScreen.name,
              builder: (context, state) {
                return const SettingScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
