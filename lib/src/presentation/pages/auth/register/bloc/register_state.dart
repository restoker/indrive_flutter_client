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
    this.email = const BlocFormItem(error: 'Ingresa el email'),
    this.password = const BlocFormItem(error: 'Ingresa el password'),
    this.confirmarPassword = const BlocFormItem(
      error: 'Confirma la contraseña',
    ),
    this.nombre = const BlocFormItem(error: 'Ingresa el nombre'),
    this.telefono = const BlocFormItem(error: 'Ingresa el telefono'),
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
    nombre,
    email,
    telefono,
    password,
    confirmarPassword,
    isValid,
    formStatus,
    passwordReveal,
    confirmarPasswordReveal,
  ];
}
