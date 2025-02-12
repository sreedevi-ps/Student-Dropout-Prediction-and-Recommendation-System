import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/themes/text_field_theme.dart';
import 'package:retentionx/features/auth/presntation/screens/login_screen.dart';
import 'package:retentionx/features/data_entry/presentation/screens/screen_admin_data_entry.dart';
import 'package:retentionx/features/navigation/presentation/home.dart';
import 'package:retentionx/features/profile/presentation/screens/profile_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
            inputDecorationTheme: TextFieldTheme.themeTextForm()),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
