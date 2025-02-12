import 'package:flutter/material.dart';
import 'package:retentionx/core/colors/app_colors.dart';

class StudentProfilePic extends StatelessWidget {
  const StudentProfilePic({
    super.key,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  // final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.navBarColor,
            radius: 50,
            child: Icon(
              Icons.person,
              color: Theme.of(context).textTheme.bodyLarge!.color,
              size: 50,
            ),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              backgroundColor: AppColors.themeColor,
              radius: 13,
              // backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
