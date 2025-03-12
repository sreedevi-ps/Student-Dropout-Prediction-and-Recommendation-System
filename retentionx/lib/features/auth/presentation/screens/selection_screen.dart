import 'package:flutter/material.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/features/auth/presentation/screens/admin_login_screen.dart';
import 'package:retentionx/features/auth/presentation/screens/student_login_screen.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            const SizedBox(height: 10),
            //image
            Center(
              child: Image.asset(
                'assets/RX logo.png',
                height: 200,
              ),
            ),
            LoginSelection(
              isAdmin: true,
            ),
            LoginSelection(
              isAdmin: false,
            ),
            //instution login
          ],
        ),
      ),
    );
  }
}

class LoginSelection extends StatelessWidget {
  const LoginSelection({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isAdmin
            ? AppRouting.go(screen: AdminLoginScreen())
            : AppRouting.go(screen: StudentLoginScreen());
      },
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          //white border
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            spacing: 20,
            children: [
              Spacer(),
              isAdmin
                  ? Icon(
                      Icons.school,
                      color: AppColors.themeColor,
                    )
                  : Icon(
                      Icons.person,
                      color: AppColors.themeColor,
                    ),
              // Spacer(),
              Text(
                isAdmin
                    ? 'Institution Login'.toString()
                    : 'Student Login'.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
            ],
          )),
    );
  }
}
