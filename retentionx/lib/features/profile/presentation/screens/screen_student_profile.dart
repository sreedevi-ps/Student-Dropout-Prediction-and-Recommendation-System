import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/core/widgets/loader/loader_widget.dart';
import 'package:retentionx/features/home/presentation/menu_changer_bloc/menu_changer_bloc.dart';
import 'package:retentionx/features/profile/data/model/student_profile_model.dart';
import 'package:retentionx/features/profile/presentation/blocs/admin_recommend/admin_recommend_bloc.dart';
import 'package:retentionx/features/profile/presentation/blocs/predict_bloc/predict_bloc.dart';
import 'package:retentionx/features/profile/presentation/blocs/student_profile_bloc/student_profile_bloc.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/performance_card.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:retentionx/features/profile/presentation/screens/widgets/student_info_card.dart';
import 'package:retentionx/features/student_list/presentation/screens/screen_students_list.dart';

class ScreenStudentProfile extends StatefulWidget {
  const ScreenStudentProfile(
      {super.key, this.studentId, required this.isAdmin});

  final String? studentId;
  final bool isAdmin;

  @override
  State<ScreenStudentProfile> createState() => _ScreenStudentProfileState();
}

class _ScreenStudentProfileState extends State<ScreenStudentProfile> {
  @override
  void initState() {
    context.read<StudentProfileBloc>().add(GetStudentProfile(widget.studentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentProfileBloc, StudentProfileState>(
      listener: (context, state) {
        if (state is StudentProfileError) {
          showCustomSnackBar(context, state.message, isError: true);
        }
        if (state is StudentProfileLoaded) {
          context
              .read<PredictBloc>()
              .add(GetPrediction(state.studentProfile.studentId));
          // ProfileRepo.predict(studentId: state.studentProfile.studentId);
        }
      },
      builder: (context, state) {
        return state is StudentProfileLoaded
            ? StudentProfile(
                studentProfile: state.studentProfile,
                isAdmin: widget.isAdmin,
              )
            : LoaderWidget();
      },
    );
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({
    super.key,
    required this.studentProfile,
    required this.isAdmin,
  });
  final StudentProfileModel studentProfile;
  final bool isAdmin;

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final TextEditingController _recommendationController =
      TextEditingController();

  @override
  void dispose() {
    _recommendationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isAdmin)
              Row(
                //end
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //close button
                  IconButton(
                    onPressed: () {
                      context.read<MenuChangerBloc>().add(MenuChangeRequested(
                          index: 0, screen: ScreenStudentsList()));
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            SizedBox(height: kToolbarHeight),
            ProfileHeader(
              title: widget.studentProfile.name,
              subtitle: widget.studentProfile.studentId,
              image: widget.studentProfile.photoUrl,
            ),
            SizedBox(height: 20),
            StudentInfoCard(
              studentProfile: widget.studentProfile,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PerformanceCard(
                  title: "Avg Enrolled",
                  value: widget.studentProfile.avgEnrolled.toString(),
                  //C4EAD5
                  bgColor: AppColors.lightGreen,
                  textColor: AppColors.darkGreen,
                ),
                PerformanceCard(
                  title: "Avg Approved",
                  value: widget.studentProfile.avgApproved.toString(),
                  bgColor: AppColors.lightBlue,
                  textColor: AppColors.darkBlue,
                ),
                PerformanceCard(
                  title: "Avg Grade",
                  value: widget.studentProfile.avgGrade.toString(),
                  bgColor: AppColors.lightRed,
                  textColor: AppColors.darkRed,
                ),
              ],
            ),
            if (widget.isAdmin)
              BlocConsumer<AdminRecommendBloc, AdminRecommendState>(
                listener: (context, state) {
                  if (state is AdminRecommendLoaded) {
                    _recommendationController.clear();
                    QuickAlert.show(
                        context: context,
                        backgroundColor: AppColors.navBarColor,
                        confirmBtnColor: AppColors.themeColor,
                        type: QuickAlertType.success,
                        text: 'Recommendation sended Successfully!',
                        titleColor: Colors.white,
                        textColor: Colors.white);
                  }
                  if (state is AdminRecommendError) {
                    showCustomSnackBar(context, state.message, isError: true);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _recommendationController,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Add recommendation",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      CommonButton(
                          isLoading: state is AdminRecommendLoading,
                          onPressed: () {
                            if (_recommendationController.text.isEmpty) {
                              showCustomSnackBar(
                                  context, "Recommendation cannot be empty",
                                  isError: true);
                              return;
                            }
                            context.read<AdminRecommendBloc>().add(
                                AdminRecommendButtonPressed(
                                    studentId: widget.studentProfile.studentId,
                                    recommendation:
                                        _recommendationController.text));
                            // ProfileRepo.adminRecommend(
                            //     studentId: widget.studentProfile.studentId,
                            //     recommendation: _recommendationController.text);
                          },
                          label:
                              "Add recommendation to ${widget.studentProfile.name}"),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            SizedBox(height: kBottomNavigationBarHeight + 20),
          ],
        ),
      ),
    );
  }
}
