import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retentionx/core/animation/app_animation_builder.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/home/presentation/menu_changer_bloc/menu_changer_bloc.dart';
import 'package:retentionx/features/profile/presentation/screens/screen_student_profile.dart';
import 'package:retentionx/features/student_list/data/model/student_list_model.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({
    super.key,
    required this.students,
  });
  final List<StudentListModel> students;
  @override
  Widget build(BuildContext context) {
    return AppAnimationBuilder(
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: students.length,
          itemBuilder: (context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              //border color
              tileColor: AppColors.navBarColor,
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: const Text('S',
                    style: TextStyle(color: AppColors.themeColor)),
              ),
              title: Text(students[index].name,
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(students[index].studentId,
                  style: TextStyle(color: Colors.white)),
              trailing: CommonButton(
                  width: 60,
                  onPressed: () {
                    context.read<MenuChangerBloc>().add(MenuChangeRequested(
                        index: 0,
                        screen: AppAnimationBuilder(
                          child: ScreenStudentProfile(
                            studentId: students[index].studentId,
                            isAdmin: true,
                          ),
                        )));
                  },
                  label: "View"),
            );
          }),
    );
  }
}
