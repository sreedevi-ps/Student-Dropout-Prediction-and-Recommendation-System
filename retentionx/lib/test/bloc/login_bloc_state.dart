part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocState {}

final class LoginBlocInitial extends LoginBlocState {}

//loading state
final class LoginBlocLoading extends LoginBlocState {}

//success state
final class LoginBlocSuccess extends LoginBlocState {
  LoginBlocSuccess();
}

//failure state
final class LoginBlocError extends LoginBlocState {
  final String message;
  LoginBlocError({required this.message});
}
