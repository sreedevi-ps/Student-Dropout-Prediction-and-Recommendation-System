import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/snack_bar/show_snack_bar.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/data_entry/core/suggestions/data_suggestions.dart';
import 'package:retentionx/features/data_entry/presentation/bloc/student_data_entry/student_data_entry_bloc.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_drop_down.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_fields.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/excel_upload_button.dart';

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

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    applicationOrderController.dispose();
    courseController.dispose();
    motherQualificationController.dispose();
    fatherQualificationController.dispose();
    motherOccupationController.dispose();
    fatherOccupationController.dispose();
    debtorController.dispose();
    tuitionFeesUpToDateController.dispose();
    genderController.dispose();
    scholarshipHolderController.dispose();
    ageController.dispose();
    gdpController.dispose();
    avgEnrolledController.dispose();
    avgApprovedController.dispose();
    avgGradeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentDataEntryBloc, StudentDataEntryState>(
      listener: (context, state) {
        if (state is StudentDataEntrySuccess) {
          clearAllControllers();
          QuickAlert.show(
              context: context,
              backgroundColor: AppColors.navBarColor,
              confirmBtnColor: AppColors.themeColor,
              type: QuickAlertType.success,
              text: 'Student data uploaded Successfully!',
              titleColor: Colors.white,
              textColor: Colors.white);
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
                spacing: 20,
                children: [
                  SizedBox(height: 20),
                  //text upload data
                  Text(
                    'Upload Student Data',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  //StudentProfilePic(),
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
                            isNumber: true,
                          ),

                          //gdp
                          DataFields(
                            label: 'GDP',
                            controller: gdpController,
                            isNumber: true,
                          ),
                          //avg enrolled
                          DataFields(
                            label: 'Avg Enrolled',
                            controller: avgEnrolledController,
                            isNumber: true,
                          ),
                          //avg approved
                          DataFields(
                            label: 'Avg Approved',
                            controller: avgApprovedController,
                            isNumber: true,
                          ),
                          //avg grade
                          DataFields(
                            label: 'Avg Grade(out of 20)',
                            controller: avgGradeController,
                            isNumber: true,
                          ),
                          //submit button
                          CommonButton(
                            isLoading: state is StudentDataEntryLoading,
                            onPressed: () {
                              try {
                                if (nameController.text.isEmpty ||
                                    idController.text.isEmpty ||
                                    courseController.text.isEmpty ||
                                    motherQualificationController
                                        .text.isEmpty ||
                                    fatherQualificationController
                                        .text.isEmpty ||
                                    motherOccupationController.text.isEmpty ||
                                    fatherOccupationController.text.isEmpty ||
                                    debtorController.text.isEmpty ||
                                    tuitionFeesUpToDateController
                                        .text.isEmpty ||
                                    genderController.text.isEmpty ||
                                    scholarshipHolderController.text.isEmpty ||
                                    ageController.text.isEmpty ||
                                    gdpController.text.isEmpty ||
                                    avgEnrolledController.text.isEmpty ||
                                    avgApprovedController.text.isEmpty ||
                                    avgGradeController.text.isEmpty) {
                                  showCustomSnackBar(
                                      context, "Please fill all the data",
                                      isError: true);
                                  return;
                                }
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
                                        debtor: debtorController.text.toLowerCase() ==
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
                                        avgGrade:
                                            double.parse(avgGradeController.text));

                                context.read<StudentDataEntryBloc>().add(
                                    StudentDataEntryButtonPressed(
                                        studentDataEntryModel:
                                            studentDataEntryModel));
                              } catch (e) {
                                showCustomSnackBar(
                                    context, "Please fill all the data",
                                    isError: true);
                              }
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

  //clear all controllers
  void clearAllControllers() {
    nameController.clear();
    idController.clear();
    applicationOrderController.clear();
    courseController.clear();
    motherQualificationController.clear();
    fatherQualificationController.clear();
    motherOccupationController.clear();
    fatherOccupationController.clear();
    debtorController.clear();
    tuitionFeesUpToDateController.clear();
    genderController.clear();
    scholarshipHolderController.clear();
    ageController.clear();
    gdpController.clear();
    avgEnrolledController.clear();
    avgApprovedController.clear();
    avgGradeController.clear();
  }
}
