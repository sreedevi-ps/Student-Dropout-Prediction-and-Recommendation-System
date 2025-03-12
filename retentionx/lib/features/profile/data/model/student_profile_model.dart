import 'package:retentionx/features/view_recommendations/data/model/recommendation.dart';

class StudentProfileModel {
  int age;
  int applicationMode;
  int applicationOrder;
  double avgApproved;
  double avgEnrolled;
  double avgGrade;
  String course;
  bool debtor;
  String fatherOccupation;
  String fatherQualification;
  double gdp;
  String gender;
  String motherOccupation;
  String motherQualification;
  String name;
  String photoUrl;
  bool scholarshipHolder;
  String studentId;
  bool tuitionFeesUpToDate;
  final List<Recommendation> recommendation;

  // Constructor
  StudentProfileModel({
    required this.age,
    required this.applicationMode,
    required this.applicationOrder,
    required this.avgApproved,
    required this.avgEnrolled,
    required this.avgGrade,
    required this.course,
    required this.debtor,
    required this.fatherOccupation,
    required this.fatherQualification,
    required this.gdp,
    required this.gender,
    required this.motherOccupation,
    required this.motherQualification,
    required this.name,
    required this.photoUrl,
    required this.scholarshipHolder,
    required this.studentId,
    required this.tuitionFeesUpToDate,
    required this.recommendation,
  });

  // Factory method to create a Student instance from JSON data
  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    var recommendations = json['data']['recommendation'] as List?;
    List<Recommendation> recommendationList = recommendations != null
        ? recommendations.map((e) => Recommendation.fromJson(e)).toList()
        : [];

    return StudentProfileModel(
      age: json['data']['age'],
      applicationMode: json['data']['application_mode'],
      applicationOrder: json['data']['application_order'],
      avgApproved: json['data']['avg_approved'],
      avgEnrolled: json['data']['avg_enrolled'],
      avgGrade: json['data']['avg_grade'],
      course: json['data']['course'],
      debtor: json['data']['debtor'],
      fatherOccupation: json['data']['father_occupation'],
      fatherQualification: json['data']['father_qualification'],
      gdp: json['data']['gdp'],
      gender: json['data']['gender'],
      motherOccupation: json['data']['mother_occupation'],
      motherQualification: json['data']['mother_qualification'],
      name: json['data']['name'],
      photoUrl: json['data']['photo_url'] ?? "",
      scholarshipHolder: json['data']['scholarship_holder'] ?? false,
      studentId: json['data']['student_id'],
      tuitionFeesUpToDate: json['data']['tuition_fees_up_to_date'],
      recommendation: recommendationList,
    );
  }

  // Method to convert Student instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': {
        'age': age,
        'application_mode': applicationMode,
        'application_order': applicationOrder,
        'avg_approved': avgApproved,
        'avg_enrolled': avgEnrolled,
        'avg_grade': avgGrade,
        'course': course,
        'debtor': debtor,
        'father_occupation': fatherOccupation,
        'father_qualification': fatherQualification,
        'gdp': gdp,
        'gender': gender,
        'mother_occupation': motherOccupation,
        'mother_qualification': motherQualification,
        'name': name,
        'photo_url': photoUrl,
        'scholarship_holder': scholarshipHolder,
        'student_id': studentId,
        'tuition_fees_up_to_date': tuitionFeesUpToDate,
      },
      'status': 'success',
    };
  }
}
