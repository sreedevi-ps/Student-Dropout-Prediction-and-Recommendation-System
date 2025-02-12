import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final Function() onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.themeColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
