import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class DataFields extends StatelessWidget {
  const DataFields({
    super.key, required this.label,
    required this.controller,  this.isNumber = false,
    this.enabled = true
  });
final String label;
final TextEditingController controller;
final bool isNumber;
final bool enabled;
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
          controller: controller,
          enabled: enabled,
           keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          style: GoogleFonts.nunito(fontSize: 16, color: AppColors.white),
          cursorColor: AppColors.white,
        ),
      ],
    );
  }
}