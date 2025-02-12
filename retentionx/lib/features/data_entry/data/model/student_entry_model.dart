class Student {
  final String studentId;
  final String name;
  final int applicationOrder;
  final int course;
  final String motherQualification;
  final String fatherQualification;
  final String motherOccupation;
  final String fatherOccupation;
  final bool debtor;
  final bool tuitionFeesUpToDate;
  final String gender;
  final bool scholarshipHolder;
  final int age;
  final double gdp;
  final double avgEnrolled;
  final double avgApproved;
  final double avgGrade;

  Student({
    required this.studentId,
    required this.name,
    required this.applicationOrder,
    required this.course,
    required this.motherQualification,
    required this.fatherQualification,
    required this.motherOccupation,
    required this.fatherOccupation,
    required this.debtor,
    required this.tuitionFeesUpToDate,
    required this.gender,
    required this.scholarshipHolder,
    required this.age,
    required this.gdp,
    required this.avgEnrolled,
    required this.avgApproved,
    required this.avgGrade,
  });

  // Factory method to create an instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['student_id'],
      name: json['name'],
      applicationOrder: json['application_order'],
      course: json['course'],
      motherQualification: json['mother_qualification'],
      fatherQualification: json['father_qualification'],
      motherOccupation: json['mother_occupation'],
      fatherOccupation: json['father_occupation'],
      debtor: json['debtor'],
      tuitionFeesUpToDate: json['tuition_fees_up_to_date'],
      gender: json['gender'],
      scholarshipHolder: json['scholarship_holder'],
      age: json['age'],
      gdp: json['gdp'].toDouble(),
      avgEnrolled: json['avg_enrolled'].toDouble(),
      avgApproved: json['avg_approved'].toDouble(),
      avgGrade: json['avg_grade'].toDouble(),
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'name': name,
      'application_order': applicationOrder,
      'course': course,
      'mother_qualification': motherQualification,
      'father_qualification': fatherQualification,
      'mother_occupation': motherOccupation,
      'father_occupation': fatherOccupation,
      'debtor': debtor,
      'tuition_fees_up_to_date': tuitionFeesUpToDate,
      'gender': gender,
      'scholarship_holder': scholarshipHolder,
      'age': age,
      'gdp': gdp,
      'avg_enrolled': avgEnrolled,
      'avg_approved': avgApproved,
      'avg_grade': avgGrade,
    };
  }
}
