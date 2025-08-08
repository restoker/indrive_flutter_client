part of 'login_bloc.dart';

// https://github.com/Klerith/flutter-formularios/blob/fin-seccion-19-formz/lib/presentation/blocs/counter_bloc/counter_state.dart
enum FormStatus { invalid, valid, validating, posting, error }

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final GlobalKey<FormState>? formKey;
  final bool isValid;
  final FormStatus formStatus;
  final bool passwordReveal;
  final bool twoFactor;
  final int pin1;
  final int pin2;
  final int pin3;
  final int pin4;
  final UserResponse? userResponse;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formKey,
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.passwordReveal = false,
    this.twoFactor = false,
    this.pin1 = 10,
    this.pin2 = 10,
    this.pin3 = 10,
    this.pin4 = 10,
    this.userResponse,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    GlobalKey<FormState>? formKey,
    bool? isValid,
    FormStatus? formStatus,
    bool? passwordReveal,
    bool? twoFactor,
    int? pin1,
    int? pin2,
    int? pin3,
    int? pin4,
    UserResponse? userResponse,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formKey: formKey ?? this.formKey,
      isValid: isValid ?? this.isValid,
      formStatus: formStatus ?? this.formStatus,
      passwordReveal: passwordReveal ?? this.passwordReveal,
      twoFactor: twoFactor ?? this.twoFactor,
      pin1: pin1 ?? this.pin1,
      pin2: pin2 ?? this.pin2,
      pin3: pin3 ?? this.pin3,
      pin4: pin4 ?? this.pin4,
      userResponse: userResponse ?? this.userResponse,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    isValid,
    formStatus,
    passwordReveal,
    twoFactor,
    pin1,
    pin2,
    pin3,
    pin4,
  ];
}
