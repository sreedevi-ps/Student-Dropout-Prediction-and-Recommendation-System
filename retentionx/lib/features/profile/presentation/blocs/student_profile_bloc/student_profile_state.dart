part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileState {}

final class StudentProfileInitial extends StudentProfileState {}

final class StudentProfileLoading extends StudentProfileState {}

final class StudentProfileLoaded extends StudentProfileState {
  final StudentProfileModel studentProfile;

  StudentProfileLoaded(this.studentProfile);
}

final class StudentProfileError extends StudentProfileState {
  final String message;

  StudentProfileError(this.message);
}
