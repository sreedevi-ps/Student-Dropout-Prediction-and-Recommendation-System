import 'package:flutter/material.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/presentation/screens/login_screen.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/profile_header.dart';

class ScreenAdminProfile extends StatelessWidget {
  const ScreenAdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(height: kToolbarHeight),
          ProfileHeader(
            title: "Admin Profile",
            subtitle: "Admin",
          ),
          Spacer(),
          CommonButton(
              onPressed: () {
                AppRouting.goRemoveAll(screen: LoginScreen(), context: context);
              },
              label: "Logout"),
          SizedBox(
            height: kBottomNavigationBarHeight + 50,
          )
        ],
      ),
    );
  }
}
