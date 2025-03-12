

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/features/profile/presentation/blocs/predict_bloc/predict_bloc.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/predit_loader.dart';

class AdminProfileHeader extends StatefulWidget {
  const AdminProfileHeader(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});
  final String title;
  final String subtitle;
  final String image;

  @override
  State<AdminProfileHeader> createState() => _AdminProfileHeaderState();
}

class _AdminProfileHeaderState extends State<AdminProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Ensures the image is not clipped
      alignment: Alignment.topCenter,
      children: [
        Card(
          color:  AppColors.navBarColor,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              //color: AppColors.navBarColor, // Dark teal color
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40), // Provides space for the image
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 10),
            
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
              child: _buildImageOrIcon(
                  imageUrl: widget.image), // Pass the image URL here
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageOrIcon({required String? imageUrl}) {
    if (isValidUrl(imageUrl)) {
      // If the URL is valid, load the NetworkImage
      try {
        return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl!),
          radius: 38,
        );
      } catch (e) {
        // If there's an error loading the image, show the default icon
        return _defaultIcon();
      }
    } else {
      // If the URL is invalid, show the default icon
      return _defaultIcon();
    }
  }

  bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) {
      return false;
    }
    final Uri? uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Widget _defaultIcon() {
    return Icon(
      Icons.person,
      color: Theme.of(context).textTheme.bodyLarge!.color,
      size: 50,
    );
  }
}
