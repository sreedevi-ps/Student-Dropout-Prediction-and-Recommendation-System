import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/animation/app_animation_builder.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class ExcelUploadButton extends StatelessWidget {
  const ExcelUploadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppAnimationBuilder(
      child: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 25),
        child: Container(
          //boder radius
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.navBarColor,
          ),
          child: FloatingActionButton.extended(
            backgroundColor:
                Colors.transparent, // Set to transparent to show gradient
            onPressed: () {},
            label: Text(
              'Upload',
              style: GoogleFonts.roboto(
                color: Colors.white,
              ),
            ),
            icon: Image.asset(
              'assets/excel.png',
              height: 24, // Adjust the size of the icon as needed
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
