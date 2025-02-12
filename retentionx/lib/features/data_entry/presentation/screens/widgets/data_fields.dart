import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class DataFields extends StatelessWidget {
  const DataFields({
    super.key, required this.label,
  });
final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        const SizedBox(height: 8),
        TextField(
          style: GoogleFonts.nunito(fontSize: 16, color: AppColors.white),
          cursorColor: AppColors.white,
        ),
      ],
    );
  }
}
