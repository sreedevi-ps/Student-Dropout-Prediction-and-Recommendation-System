import 'package:flutter/material.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Ensures the image is not clipped
      alignment: Alignment.topCenter,
      children: [
        Card(
          color: AppColors.navBarColor,
          child: Container(
            width: double.infinity,
            height: 110,
            decoration: BoxDecoration(
              color: AppColors.navBarColor, // Dark teal color
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), // Provides space for the image
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -40, // Adjust to position the image fully visible
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              backgroundColor: AppColors.navBarColor,
              radius: 38,
              child: Icon(
                Icons.person,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
