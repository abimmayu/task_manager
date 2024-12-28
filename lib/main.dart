import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/core/utils/depedency_injection.dart' as di;
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/bloc/splash/splash_bloc.dart';
import 'package:task_manager/features/task/presentation/bloc/task_bloc.dart';

void main() async {
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          ],
          child: MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            debugShowCheckedModeBanner: false,
            title: 'Task Manager',
          ),
        );
      },
    );
  }
}
