import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/themes/text_field_theme.dart';
import 'package:retentionx/features/auth/presentation/screens/bloc/auth_bloc.dart';
import 'package:retentionx/features/auth/presentation/screens/login_screen.dart';
import 'package:retentionx/features/data_entry/presentation/screens/screen_admin_data_entry.dart';
import 'package:retentionx/features/home/presentation/home.dart';
import 'package:retentionx/features/profile/presentation/screens/screen_student_profile.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: Flexify(
        designWidth: 375,
        designHeight: 812,
        app: MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.bgColor,
                textTheme: GoogleFonts.nunitoTextTheme(
                    Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
                inputDecorationTheme: TextFieldTheme.themeTextForm()),
            debugShowCheckedModeBanner: false,
            home: LoginScreen()),
      ),
    );
  }
}
