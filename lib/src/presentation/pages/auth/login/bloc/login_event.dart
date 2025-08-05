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

class FormReset extends LoginEvent {}

class Ping1Changed extends LoginEvent {
  final int pin1;
  Ping1Changed({required this.pin1});
}

class Ping2Changed extends LoginEvent {
  final int pin2;
  Ping2Changed({required this.pin2});
}

class Ping3Changed extends LoginEvent {
  final int pin3;
  Ping3Changed({required this.pin3});
}

class Ping4Changed extends LoginEvent {
  final int pin4;
  Ping4Changed({required this.pin4});
}

class LoginSubmitTwoFactorEvent extends LoginEvent {}

class TogglePasswordEvent extends LoginEvent {}
