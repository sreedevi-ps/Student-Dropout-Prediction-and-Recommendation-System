import 'package:flutter/material.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/auth/presentation/screens/login_screen.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/performance_card.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/student_info_card.dart';
import 'package:retentionx/features/view_recommendations/presentation/screens/view_recommendations.dart';

class ScreenStudentProfile extends StatelessWidget {
  const ScreenStudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            SizedBox(height: kToolbarHeight),
            ProfileHeader(
              title: "Student Profile",
              subtitle: "Student",
            ),
            StudentInfoCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PerformanceCard(
                  title: "Avg Enrolled",
                  value: "80%",
                  //C4EAD5
                  bgColor: AppColors.lightGreen,
                  textColor: AppColors.darkGreen,
                ),
                PerformanceCard(
                  title: "Avg Approved",
                  value: "80%",
                  bgColor: AppColors.lightBlue,
                  textColor: AppColors.darkBlue,
                ),
                PerformanceCard(
                  title: "Avg Grade",
                  value: "80%",
                  bgColor: AppColors.lightRed,
                  textColor: AppColors.darkRed,
                ),
              ],
            ),
            CommonButton(
                btnColor: AppColors.orange,
                onPressed: () {
                  AppRouting.goRemoveAll(
                      screen: LoginScreen(), context: context);
                  //clear data
                  LocalDatabase().deleteData('user');
                },
                label: "View Recommendations"),
            //sizedbox
            // SizedBox(height: 1),
            CommonButton(
                //FFA725

                onPressed: () {
                  AppRouting.goRemoveAll(
                      screen: LoginScreen(), context: context);
                  //clear data
                  LocalDatabase().deleteData('user');
                },
                label: "Logout"),
            SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}
