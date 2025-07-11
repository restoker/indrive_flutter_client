part of 'register_bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterInitEvent extends RegisterEvent {
  const RegisterInitEvent();
}

class RegisterSubmit extends RegisterEvent {
  const RegisterSubmit();
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged({required this.password});
}

class RegisterConfirmarPasswordChanged extends RegisterEvent {
  final String confirmarPassword;
  const RegisterConfirmarPasswordChanged({required this.confirmarPassword});
}

class RegisterNombreChanged extends RegisterEvent {
  final String nombre;
  const RegisterNombreChanged({required this.nombre});
}

class RegisterTelefonoChanged extends RegisterEvent {
  final String telefono;
  const RegisterTelefonoChanged({required this.telefono});
}

class FormReset extends RegisterEvent {}

class TogglePasswordEvent extends RegisterEvent {}

class ToggleConfirmarPasswordEvent extends RegisterEvent {}
