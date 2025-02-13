import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/themes/text_field_theme.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/data/repo/auth_repo.dart';
import 'package:retentionx/features/auth/presentation/screens/bloc/auth_bloc.dart';
import 'package:retentionx/features/home/presentation/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //usernamecontroller
  final usernameController = TextEditingController();
  //passwordcontroller
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
       
        if (state is AuthSuccess) {
          AppRouting.goRemoveAll(
              screen: Home(
                isAdmin: state.isAdmin,
              ),
              context: context);
        }
        if (state is AuthError) {
          HapticFeedback.vibrate();
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  //image
                  Image.asset(
                    'assets/RX logo.png',
                    height: 200,
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.nunito(
                      fontSize: 32,

                      fontWeight: FontWeight.bold,
                      // color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email field
                  Text(
                    'UserName',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      // color: Color(0xFF1A237E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: usernameController,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                    ),
                    cursorColor: AppColors.white,
                    // decoration: TextFieldTheme.themeTextForm(
                    //   Icons.email,
                    // ),
                  ),
                  const SizedBox(height: 24),

                  // Password field
                  Text(
                    'Password',
                    style:
                        GoogleFonts.nunito(fontSize: 16, color: AppColors.white
                            //color: Color(0xFF1A237E),
                            ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    style: GoogleFonts.nunito(
                        fontSize: 16, color: AppColors.white),
                    cursorColor: AppColors.white,
                    obscureText: true,
                    obscuringCharacter: '*',
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.nunito(
                          color: AppColors.white,
                          // color: Color(0xFF1A237E),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  //  const Spacer(),

                  // Login Button
                  CommonButton(
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginButtonPressed(
                            userName: usernameController.text,
                            password: passwordController.text,
                          ));
                    },
                    label: 'Login',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
