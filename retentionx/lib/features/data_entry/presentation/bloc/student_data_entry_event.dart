part of 'student_data_entry_bloc.dart';

@immutable
sealed class StudentDataEntryEvent {}

//button pressed
final class StudentDataEntryButtonPressed extends StudentDataEntryEvent {
  final StudentDataEntryModel studentDataEntryModel;

  StudentDataEntryButtonPressed({required this.studentDataEntryModel});
}

