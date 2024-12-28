import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/constant/assets.dart';
import 'package:task_manager/core/route/route.dart';
import 'package:task_manager/core/widget/button.dart';
import 'package:task_manager/core/widget/button_loading.dart';
import 'package:task_manager/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:task_manager/features/auth/presentation/screen/widget/text_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obsecureStatus = true;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logo,
              height: 500.h,
            ),
            const Text("Register"),
            const SizedBox(
              height: 20,
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
              onVisibility: () {
                setState(() {
                  obsecureStatus = !obsecureStatus;
                });
              },
              prefixIcon: Icons.password,
              controller: passwordController,
              obsecureStatus: obsecureStatus,
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
                  return const ButtonLoading();
                } else {
                  return ButtonFilled(
                    onTap: () => context.read<AuthBloc>().add(
                          AuthRegister(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        ),
                    hintText: "Register",
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Have an account?"),
                TextButton(
                  onPressed: () {
                    context.goNamed(AppRoute.loginScreen.name);
                  },
                  child: const Text("Login"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
