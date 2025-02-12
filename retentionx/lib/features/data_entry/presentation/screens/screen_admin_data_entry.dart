import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retentionx/core/colors/app_colors.dart';
import 'package:retentionx/core/widgets/buttons/common_button.dart';
import 'package:retentionx/features/data_entry/core/suggestions/data_suggestions.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_drop_down.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/data_fields.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/excel_upload_button.dart';
import 'package:retentionx/features/data_entry/presentation/screens/widgets/student_profile_pic.dart';

class ScrenAdminDataEntry extends StatefulWidget {
  const ScrenAdminDataEntry({super.key});

  @override
  State<ScrenAdminDataEntry> createState() => _ScrenAdminDataEntryState();
}

class _ScrenAdminDataEntryState extends State<ScrenAdminDataEntry> {
  //text controllers
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 18,
                children: [
                  StudentProfilePic(),
                  DataFields(
                    label: 'Name',
                  ),
                  //id
                  DataFields(
                    label: 'Id',
                  ),
                  //application order
                  DataFields(
                    label: 'Application Order',
                  ),
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
                  DataFields(
                    label: 'Debtor',
                  ),

                  //tuition fees up to date
                  DataFields(
                    label: 'Tuition fees up to date',
                  ),

                  //gender
                  DataFields(
                    label: "Gender",
                  ),
                  //scholarship holder
                  DataFields(
                    label: 'Scholarship Holder',
                  ),
                  //age
                  DataFields(
                    label: 'Age',
                  ),

                  //gdp
                  DataFields(
                    label: 'GDP',
                  ),
                  //avg enrolled
                  DataFields(
                    label: 'Avg Enrolled',
                  ),
                  //avg approved
                  DataFields(
                    label: 'Avg Approved',
                  ),
                  //avg grade
                  DataFields(
                    label: 'Avg Grade',
                  ),
                  //submit button
                  CommonButton(
                    onPressed: () {},
                    label: 'Upload',
                  ),
                  SizedBox(height: kBottomNavigationBarHeight),
                ],
              ),
            ),
          ),
          DraggableWidget(
              bottomMargin: 50,
              topMargin: 50,
              horizontalSpace: 20,
              child: ExcelUploadButton()),
        ],
      ),
    );
  }
}
