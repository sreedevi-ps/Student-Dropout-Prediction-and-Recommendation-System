part of 'student_list_bloc.dart';

@immutable
sealed class StudentListState {}

final class StudentListInitial extends StudentListState {}

//loading state
final class StudentListLoading extends StudentListState {}

//error state
final class StudentListError extends StudentListState {
  final String message;

  StudentListError(this.message);
}

//success state
final class StudentListSuccess extends StudentListState {
  final List<StudentListModel> students;

  StudentListSuccess(this.students);
}