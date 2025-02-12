import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/themes/text_field_theme.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Email',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  // color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
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
                style: GoogleFonts.nunito(fontSize: 16, color: AppColors.white
                    //color: Color(0xFF1A237E),
                    ),
              ),
              const SizedBox(height: 8),
              TextField(
                style: GoogleFonts.nunito(fontSize: 16, color: AppColors.white),
                cursorColor: AppColors.white,
                obscureText: true,
                obscuringCharacter: '*',
                //icon: Icon(Icons.visibility_off),

                // decoration: TextFieldTheme.themeTextForm(
                //   Icons.visibility_off,
                // ),
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
                onPressed: () {},
                label: 'Login',
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
