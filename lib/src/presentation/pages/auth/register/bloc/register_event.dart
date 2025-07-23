part of 'register_bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterInitEvent extends RegisterEvent {
  const RegisterInitEvent();
}

class RegisterSubmit extends RegisterEvent {}

class RegisterEmailChanged extends RegisterEvent {
  final BlocFormItem email;
  const RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final BlocFormItem password;
  const RegisterPasswordChanged({required this.password});
}

class RegisterConfirmarPasswordChanged extends RegisterEvent {
  final BlocFormItem confirmarPassword;
  const RegisterConfirmarPasswordChanged({required this.confirmarPassword});
}

class RegisterNombreChanged extends RegisterEvent {
  final BlocFormItem nombre;
  const RegisterNombreChanged({required this.nombre});
}

class RegisterTelefonoChanged extends RegisterEvent {
  final BlocFormItem telefono;
  const RegisterTelefonoChanged({required this.telefono});
}

class FormReset extends RegisterEvent {}

class TogglePasswordEvent extends RegisterEvent {}

class ToggleConfirmarPasswordEvent extends RegisterEvent {}
