import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.btnColor,
    this.width,
  });
  final Function() onPressed;
  final String label;
  final bool isLoading;
  final Color? btnColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width ?? double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor ?? AppColors.themeColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SpinKitCircle(
                color: Colors.white,
                size: 20,
              )
            : Text(
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
