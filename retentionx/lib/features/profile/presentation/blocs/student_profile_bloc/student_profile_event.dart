part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileEvent {}

//get student profile
class GetStudentProfile extends StudentProfileEvent {
  final String? studentId;

  GetStudentProfile(this.studentId);
}
