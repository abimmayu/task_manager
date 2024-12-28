import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
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
    requestNotificationPermission();
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
                if (context.mounted) {
                  navigateTo(context, AppRoute.loginScreen.name);
                }
              } else {
                if (context.mounted) {
                  navigateTo(context, AppRoute.homeScreen.name);
                }
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

  void requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      debugPrint('Izin notifikasi diberikan');
    } else if (status.isDenied) {
      debugPrint('Izin notifikasi ditolak');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
