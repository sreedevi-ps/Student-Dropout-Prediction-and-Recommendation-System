import 'package:flutter/material.dart';
import 'package:retentionx/core/animation/app_animation_builder.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/student_list/data/model/student_model.dart';

class StudentListWidget extends StatelessWidget {
  const StudentListWidget({
    super.key,
    required this.students,
  });
  final List<StudentListModel> students;
  @override
  Widget build(BuildContext context) {
    return AppAnimationBuilder(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Students List',
              style: TextStyle(
                  color: AppColors.themeColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
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
                          width: 60, onPressed: () {}, label: "View"),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
