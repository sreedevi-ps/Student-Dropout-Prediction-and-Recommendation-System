part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//loading
final class AuthLoading extends AuthState {}

//error
final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

//success
final class AuthSuccess extends AuthState {
 final UserLoginModel userLoginModel;

  AuthSuccess(this.userLoginModel);
}
