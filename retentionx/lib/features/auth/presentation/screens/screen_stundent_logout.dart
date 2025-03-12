import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retentionx/core/app_routing/app_routing.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/local_db/localdb.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/core/widgets/loader/loader_widget.dart';
import 'package:retentionx/features/auth/presentation/screens/selection_screen.dart';
import 'package:retentionx/features/auth/presentation/screens/student_login_screen.dart';
import 'package:retentionx/features/profile/data/model/student_profile_model.dart';
import 'package:retentionx/features/profile/data/repo/profile_repo.dart';
import 'package:retentionx/features/profile/presentation/blocs/student_profile_bloc/student_profile_bloc.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/performance_card.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/student_info_card.dart';
import 'package:retentionx/features/view_recommendations/presentation/screens/view_recommendations.dart';

class ScreenStudentLogout extends StatelessWidget {
  const ScreenStudentLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentProfileBloc, StudentProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              SizedBox(height: kToolbarHeight),
              ProfileHeader(
                title: state is StudentProfileLoaded
                    ? state.studentProfile.name
                    : "",
                subtitle: state is StudentProfileLoaded
                    ? state.studentProfile.studentId
                    : "",
                image: state is StudentProfileLoaded
                    ? state.studentProfile.photoUrl
                    : "",
              ),
              Spacer(),
              CommonButton(
                  //FFA725

                  onPressed: () {
                    AppRouting.goRemoveAll(
                        screen: SelectionScreen(), context: context);
                    //clear data
                    LocalDatabase().deleteData('user');
                  },
                  label: "Logout"),
              SizedBox(height: kBottomNavigationBarHeight + 10),
            ],
          ),
        );
      },
    );
  }
}
