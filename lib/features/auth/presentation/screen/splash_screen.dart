// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/constant/assets.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/features/auth/presentation/bloc/splash/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateTo(BuildContext context, String approute) {
    context.goNamed(approute);
  }

  @override
  void initState() {
    context.read<SplashBloc>().add(SplashStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              if (state is SplashHaveInternet) {
                navigateTo(context, AppRoute.loginScreen.name);
              } else {
                navigateTo(context, AppRoute.homeScreen.name);
              }
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.logo),
          ],
        ),
      ),
    );
  }
}
