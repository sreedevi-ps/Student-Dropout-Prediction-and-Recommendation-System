import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retentionx/core/device/device_utils.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/data_entry/core/suggestions/data_suggestions.dart';
import 'package:retentionx/features/data_entry/data/repo/student_data_entry_repo.dart';
import 'package:retentionx/features/data_entry/presentation/bloc/student_data_entry_bloc.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_drop_down.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_fields.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/excel_upload_button.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/student_profile_pic.dart';

import '../../data/model/student_entry_model.dart';

class ScreenStudentDataEntry extends StatefulWidget {
  const ScreenStudentDataEntry({super.key});

  @override
  State<ScreenStudentDataEntry> createState() => _ScreenStudentDataEntryState();
}

class _ScreenStudentDataEntryState extends State<ScreenStudentDataEntry> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController applicationOrderController =
      TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController motherQualificationController =
      TextEditingController();
  final TextEditingController fatherQualificationController =
      TextEditingController();
  final TextEditingController motherOccupationController =
      TextEditingController();
  final TextEditingController fatherOccupationController =
      TextEditingController();
  final TextEditingController debtorController = TextEditingController();
  final TextEditingController tuitionFeesUpToDateController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController scholarshipHolderController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController gdpController = TextEditingController();
  final TextEditingController avgEnrolledController = TextEditingController();
  final TextEditingController avgApprovedController = TextEditingController();
  final TextEditingController avgGradeController = TextEditingController();

//TODO: DISPOSE ALL CONTROLLRES
//TODO: STATE MANAGEMENT
//TODO: FORM VALIDATE

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDataEntryBloc, StudentDataEntryState>(
      listener: (context, state) {
        if (state is StudentDataEntrySuccess) {
          // DeviceUtils.showSnackBar(context, state.message);
        }
        if (state is StudentDataEntryError) {
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  StudentProfilePic(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 18,
                        children: [
                          DataFields(
                            label: 'Name',
                            controller: nameController,
                          ),
                          //id
                          DataFields(
                            label: 'Id',
                            controller: idController,
                          ),
                          //application order
                          // DataFields(
                          //   label: 'Application Order',
                          //   controller: applicationOrderController,
                          // ),
                          //course
                          DataDropDown(
                              suggestions: DataSuggestions.courses,
                              controller: courseController,
                              label: "Course"),
                          //mother qualification

                          DataDropDown(
                              suggestions: DataSuggestions.parentQualifications,
                              controller: motherQualificationController,
                              label: 'Mother Qualification'),

                          //father qualification
                          DataDropDown(
                              suggestions: DataSuggestions.parentQualifications,
                              controller: fatherQualificationController,
                              label: 'Father Qualification'),

                          //mother occupation
                          DataDropDown(
                            label: 'Mother Occupation',
                            suggestions: DataSuggestions.parenstsOccupations,
                            controller: motherOccupationController,
                          ),

                          //father occupation
                          DataDropDown(
                            label: 'Father Occupation',
                            suggestions: DataSuggestions.parenstsOccupations,
                            controller: fatherOccupationController,
                          ),

                          //debtor
                          DataDropDown(
                            label: 'Having debt?',
                            controller: debtorController,
                            suggestions: [
                              'Yes',
                              'No',
                            ],
                          ),

                          //tuition fees up to date
                          DataDropDown(
                            enabled: true,
                            controller: tuitionFeesUpToDateController,
                            label: 'Tuition fees up to date',
                            suggestions: [
                              'Yes',
                              'No',
                            ],
                          ),

                          //gender
                          DataDropDown(
                            // enabled: false,
                            label: "Gender",
                            controller: genderController,
                            suggestions: [
                              'Male',
                              'Female',
                            ],
                          ),
                          //scholarship holder
                          DataDropDown(
                            // enabled: false,
                            label: 'Scholarship Holder',
                            controller: scholarshipHolderController,
                            suggestions: [
                              'Yes',
                              'No',
                            ],
                          ),
                          //age
                          DataFields(
                            label: 'Age',
                            controller: ageController,
                          ),

                          //gdp
                          DataFields(
                            label: 'GDP',
                            controller: gdpController,
                          ),
                          //avg enrolled
                          DataFields(
                            label: 'Avg Enrolled',
                            controller: avgEnrolledController,
                          ),
                          //avg approved
                          DataFields(
                            label: 'Avg Approved',
                            controller: avgApprovedController,
                          ),
                          //avg grade
                          DataFields(
                            label: 'Avg Grade(out of 20)',
                            controller: avgGradeController,
                          ),
                          //submit button
                          CommonButton(
                            isLoading: state is StudentDataEntryLoading,
                            onPressed: () {
                              final StudentDataEntryModel studentDataEntryModel =
                                  StudentDataEntryModel(
                                      studentId: idController.text,
                                      name: nameController.text,
                                      course: courseController.text,
                                      motherQualification:
                                          motherQualificationController.text,
                                      fatherQualification:
                                          fatherQualificationController.text,
                                      motherOccupation:
                                          motherOccupationController.text,
                                      fatherOccupation:
                                          fatherOccupationController.text,
                                      debtor:
                                          debtorController.text.toLowerCase() ==
                                              "true",
                                      tuitionFeesUpToDate:
                                          tuitionFeesUpToDateController.text
                                                  .toLowerCase() ==
                                              "true",
                                      gender: genderController.text,
                                      scholarshipHolder:
                                          scholarshipHolderController.text
                                                  .toLowerCase() ==
                                              "true",
                                      age: int.parse(ageController.text),
                                      gdp: double.parse(gdpController.text),
                                      avgEnrolled: double.parse(
                                          avgEnrolledController.text),
                                      avgApproved: double.parse(
                                          avgApprovedController.text),
                                      avgGrade: double.parse(avgGradeController.text));

                              context.read<StudentDataEntryBloc>().add(
                                  StudentDataEntryButtonPressed(
                                      studentDataEntryModel:
                                          studentDataEntryModel));
                            },
                            label: 'Upload',
                          ),
                          SizedBox(height: kBottomNavigationBarHeight),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DraggableWidget(
                bottomMargin: 50,
                topMargin: 50,
                horizontalSpace: 20,
                child: ExcelUploadButton()),
          ],
        );
      },
    );
  }
}
