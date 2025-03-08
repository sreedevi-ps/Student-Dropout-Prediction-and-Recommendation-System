part of 'student_list_bloc.dart';

@immutable
sealed class StudentListEvent {}

/// Fetches the list of students
class FetchStudentsList extends StudentListEvent {}
