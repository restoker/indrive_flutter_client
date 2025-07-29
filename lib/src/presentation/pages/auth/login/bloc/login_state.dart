part of 'login_bloc.dart';

// https://github.com/Klerith/flutter-formularios/blob/fin-seccion-19-formz/lib/presentation/blocs/counter_bloc/counter_state.dart
enum FormStatus { invalid, valid, validating, posting }

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final GlobalKey<FormState>? formKey;
  final bool isValid;
  final FormStatus formStatus;
  final bool passwordReveal;
  final String code;
  final bool twoFactor;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formKey,
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.passwordReveal = false,
    this.code = '',
    this.twoFactor = false,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    GlobalKey<FormState>? formKey,
    bool? isValid,
    FormStatus? formStatus,
    bool? passwordReveal,
    String? code,
    bool? twoFactor,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formKey: formKey ?? this.formKey,
      isValid: isValid ?? this.isValid,
      formStatus: formStatus ?? this.formStatus,
      passwordReveal: passwordReveal ?? this.passwordReveal,
      code: code ?? this.code,
      twoFactor: twoFactor ?? this.twoFactor,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    isValid,
    formStatus,
    passwordReveal,
    code,
    twoFactor,
  ];
}
