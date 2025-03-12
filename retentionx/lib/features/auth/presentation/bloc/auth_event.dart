part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//Login button pressed
class LoginButtonPressed extends AuthEvent {
  final String userName;
  final String password;
  LoginButtonPressed({required this.userName, required this.password});
}


