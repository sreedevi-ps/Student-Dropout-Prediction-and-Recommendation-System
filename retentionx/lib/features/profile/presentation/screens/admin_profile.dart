import 'package:flutter/material.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/presentation/screens/selection_screen.dart';
import 'package:retentionx/features/auth/presentation/screens/student_login_screen.dart';
import 'package:retentionx/features/profile/presentation/screens/admin_profile_header.dart';
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
          AdminProfileHeader(
            title: "Admin Profile",
            subtitle: "Admin",
            image: "",
          ),
          Spacer(),
          CommonButton(
              onPressed: () {
                AppRouting.goRemoveAll(
                    screen: SelectionScreen(), context: context);
                //clear data
                LocalDatabase().deleteData('user');
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
