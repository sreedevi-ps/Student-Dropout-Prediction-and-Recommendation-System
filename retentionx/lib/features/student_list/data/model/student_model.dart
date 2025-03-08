

class StudentListModel {
  final String name;
  final String studentId;

  StudentListModel({required this.name, required this.studentId});

  // Factory method to create a Student from JSON
  factory StudentListModel.fromJson(Map<String, dynamic> json) {
    return StudentListModel(
      name: json['name'],
      studentId: json['student_id'],
    );
  }

  // Method to convert Student object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'student_id': studentId,
    };
  }
}
