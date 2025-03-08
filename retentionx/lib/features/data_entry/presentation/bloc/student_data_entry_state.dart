part of 'student_data_entry_bloc.dart';

@immutable
sealed class StudentDataEntryState {}

final class StudentDataEntryInitial extends StudentDataEntryState {}

//loading 
final class StudentDataEntryLoading extends StudentDataEntryState {}

//success
final class StudentDataEntrySuccess extends StudentDataEntryState {
  final String message;
  
  StudentDataEntrySuccess({required this.message});
}

//error
final class StudentDataEntryError extends StudentDataEntryState {
  final String message;
  
  StudentDataEntryError({required this.message});
}


