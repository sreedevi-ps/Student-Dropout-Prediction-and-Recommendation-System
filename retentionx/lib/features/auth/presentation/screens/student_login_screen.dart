import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:retentionx/features/home/presentation/home.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  //usernamecontroller
  final usernameController = TextEditingController();
  //passwordcontroller
  final passwordController = TextEditingController();

  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          LocalDatabase().saveData('user', {
            "isadmin": state.userLoginModel.isAdmin,
            "id": state.userLoginModel.id,
            "user": state.userLoginModel.user ,
          });
          AppRouting.goRemoveAll(
              screen: Home(
                isAdmin: state.userLoginModel.isAdmin,
               
              ),
              context: context);
        }
        if (state is AuthError) {
          HapticFeedback.vibrate();
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: AppColors.bgColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    //image
                    Image.asset(
                      'assets/RX logo.png',
                      height: 200,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to RetentionX!',
                            style: GoogleFonts.fredoka(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Your Journey, Our Insights',
                            style: GoogleFonts.fredoka(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
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
                    TextFormField(
                      controller: usernameController,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                      ),
                      cursorColor: AppColors.white,
                      // decoration: TextFieldTheme.themeTextForm(
                      //   Icons.email,
                      // ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Password field
                    Text(
                      'Password',
                      style: GoogleFonts.nunito(
                          fontSize: 16, color: AppColors.white
                          //color: Color(0xFF1A237E),
                          ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: passwordController,
                      style: GoogleFonts.nunito(
                          fontSize: 16, color: AppColors.white),
                      cursorColor: AppColors.white,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),

                    // Forgot Password
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text(
                    //       'Forgot Password?',
                    //       style: GoogleFonts.nunito(
                    //         color: AppColors.white,
                    //         // color: Color(0xFF1A237E),
                    //         fontSize: 14,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // const Spacer(),
                    const SizedBox(height: 20),
                    CommonButton(
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(LoginButtonPressed(
                                userName: usernameController.text,
                                password: passwordController.text,
                              ));
                        }
                      },
                      label: 'Login',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
