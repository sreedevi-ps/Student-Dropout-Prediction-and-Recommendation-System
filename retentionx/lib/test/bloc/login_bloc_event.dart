part of 'login_bloc_bloc.dart';

@immutable
sealed class LoginBlocEvent {}

//login button pressded
class LoginButtonPressed extends LoginBlocEvent {
  final String userName;
  final String password;
  LoginButtonPressed({required this.userName, required this.password});
}

//foregot password button pressed
class ForgotPasswordButtonPressed extends LoginBlocEvent {}
