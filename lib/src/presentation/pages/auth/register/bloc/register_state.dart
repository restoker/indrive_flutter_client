part of 'register_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterState extends Equatable {
  final Email email;
  final PasswordRegister password;
  final ConfirmarPassword confirmarPassword;
  final Nombre nombre;
  final Telefono telefono;
  final bool isValid;
  final FormStatus formStatus;
  final GlobalKey<FormState>? formKey;
  final bool passwordReveal;
  final bool confirmarPasswordReveal;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const PasswordRegister.pure(confirmPassword: ''),
    this.confirmarPassword = const ConfirmarPassword.pure(password: ''),
    this.nombre = const Nombre.pure(),
    this.telefono = const Telefono.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.formKey,
    this.passwordReveal = false,
    this.confirmarPasswordReveal = false,
  });

  RegisterState copyWith({
    Email? email,
    PasswordRegister? password,
    ConfirmarPassword? confirmarPassword,
    Nombre? nombre,
    Telefono? telefono,
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
