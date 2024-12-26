import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/features/auth/presentation/screen/login_screen.dart';
import 'package:task_manager/features/auth/presentation/screen/register_screen.dart';
import 'package:task_manager/features/auth/presentation/screen/splash_screen.dart';

enum AppRoute {
  splashScreen,
  loginScreen,
  registerScreen,
  homeScreen,
  addTaskScreen,
  editTaskScreen,
  profileScreen,
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
              return const Placeholder();
            },
            routes: [
              GoRoute(
                path: '/add-task',
                name: AppRoute.addTaskScreen.name,
                builder: (context, state) {
                  return const Placeholder();
                },
              ),
              GoRoute(
                path: '/edit-task',
                name: AppRoute.editTaskScreen.name,
                builder: (context, state) {
                  return const Placeholder();
                },
              ),
              GoRoute(
                path: '/profile',
                name: AppRoute.profileScreen.name,
                builder: (context, state) {
                  return const Placeholder();
                },
              ),
            ]),
      ],
    ),
  ],
);
