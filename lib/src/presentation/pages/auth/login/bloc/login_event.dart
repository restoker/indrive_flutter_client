part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginInitEvent extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class LoginSubmitEvent extends LoginEvent {}
