import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager/core/theme/app_thene.dart';
import 'package:task_manager/features/task/presentation/bloc/theme/theme_bloc.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/core/utils/depedency_injection.dart' as di;
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/bloc/splash/splash_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  tz.initializeTimeZones();

  final localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);

  await localNotificationsPlugin.initialize(initSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => di.sl<AuthBloc>(),
            ),
            BlocProvider(
              create: (_) => di.sl<SplashBloc>(),
            ),
            BlocProvider(
              create: (_) => di.sl<TaskBloc>(),
            ),
            BlocProvider(
              create: (_) => di.sl<ThemeCubit>(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return MaterialApp.router(
                routerDelegate: router.routerDelegate,
                routeInformationParser: router.routeInformationParser,
                routeInformationProvider: router.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                theme: isDarkMode ? darkTheme : lightTheme,
                title: 'Task Manager',
              );
            },
          ),
        );
      },
    );
  }
}
