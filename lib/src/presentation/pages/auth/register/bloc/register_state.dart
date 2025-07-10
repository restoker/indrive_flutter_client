part of 'register_bloc.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmarPassword confirmarPassword;
  final Nombre nombre;
  final Telefono telefono;
  final bool isValid;
  final FormStatus formStatus;
  final GlobalKey<FormState>? formKey;

  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmarPassword = const ConfirmarPassword.pure(password: ''),
    this.nombre = const Nombre.pure(),
    this.telefono = const Telefono.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.formKey,
  });

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmarPassword? confirmarPassword,
    Nombre? nombre,
    Telefono? telefono,
    bool? isValid,
    FormStatus? formStatus,
    GlobalKey<FormState>? formKey,
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
  ];
}
