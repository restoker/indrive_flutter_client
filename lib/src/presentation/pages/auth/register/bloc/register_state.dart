part of 'register_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterState extends Equatable {
  final BlocFormItem nombre;
  final BlocFormItem email;
  final BlocFormItem password;
  final BlocFormItem confirmarPassword;
  final BlocFormItem telefono;
  final bool isValid;
  final FormStatus formStatus;
  final GlobalKey<FormState>? formKey;
  final bool passwordReveal;
  final bool confirmarPasswordReveal;

  const RegisterState({
    this.email = const BlocFormItem(error: 'El campo es requerido'),
    this.password = const BlocFormItem(error: 'El campo es requerido'),
    this.confirmarPassword = const BlocFormItem(error: 'El campo es requerido'),
    this.nombre = const BlocFormItem(error: 'El campo es requerido'),
    this.telefono = const BlocFormItem(error: 'El campo es requerido'),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.formKey,
    this.passwordReveal = false,
    this.confirmarPasswordReveal = false,
  });

  RegisterState copyWith({
    BlocFormItem? email,
    BlocFormItem? password,
    BlocFormItem? confirmarPassword,
    BlocFormItem? nombre,
    BlocFormItem? telefono,
    bool? isValid,
    FormStatus? formStatus,
    GlobalKey<FormState>? formKey,
    bool? passwordReveal,
    bool? confirmarPasswordReveal,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmarPassword: confirmarPassword ?? this.confirmarPassword,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      isValid: isValid ?? this.isValid,
      formStatus: formStatus ?? this.formStatus,
      formKey: formKey ?? this.formKey,
      passwordReveal: passwordReveal ?? this.passwordReveal,
      confirmarPasswordReveal:
          confirmarPasswordReveal ?? this.confirmarPasswordReveal,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    confirmarPassword,
    nombre,
    telefono,
    isValid,
    formStatus,
    passwordReveal,
    confirmarPasswordReveal,
  ];
}
