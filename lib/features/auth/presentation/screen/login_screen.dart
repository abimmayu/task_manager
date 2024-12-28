import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/constant/assets.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/screen/widget/text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blocController = context.read<AuthBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: SizedBox(
          height: 1.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageAssets.logo,
                height: 500.h,
              ),
              SizedBox(
                height: 50.h,
              ),
              TextFormWidget(
                prefixIcon: Icons.email,
                controller: emailController,
                hintText: "Email",
              ),
              SizedBox(
                height: 35.h,
              ),
              TextFormWidget(
                prefixIcon: Icons.password,
                controller: passwordController,
                obsecureStatus: true,
                hintText: "Password",
              ),
              SizedBox(
                height: 35.h,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthDone) {
                    context.goNamed(AppRoute.homeScreen.name);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return ElevatedButton(
                      onPressed: () {},
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        blocController.add(
                          AuthLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      child: const Text("Login"),
                    );
                  }
                },
              ),
              SizedBox(
                height: 100.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      context.goNamed(AppRoute.registerScreen.name);
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
