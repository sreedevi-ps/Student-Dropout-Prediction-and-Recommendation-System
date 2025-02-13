import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retentionx/core/api/api_urls.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/data/repo/auth_repo.dart';
import 'package:retentionx/test/bloc/login_bloc_bloc.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  final TextEditingController userNameController = TextEditingController();
  //password
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBlocBloc, LoginBlocState>(
      listener: (context, state) {
        if (state is LoginBlocSuccess) {
          print("Go to next page");
        }
        if (state is LoginBlocError) {
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(children: [
            SizedBox(height: 20),
            Center(child: Text("Login Test")),
            SizedBox(height: 20),
            TextFormField(
              controller: userNameController,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
            ),
            SizedBox(height: 20),
            CommonButton(
                onPressed: () {
                  context.read<LoginBlocBloc>().add(LoginButtonPressed(
                        userName: userNameController.text,
                        password: passwordController.text,
                      ));
                },
                label: "Login")
          ]),
        ),
      ),
    );
  }
}
