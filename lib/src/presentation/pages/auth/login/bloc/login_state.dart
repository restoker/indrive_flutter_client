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
  final bool twoFactor;
  final Pin pin1;
  final Pin pin2;
  final Pin pin3;
  final Pin pin4;

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formKey,
    this.isValid = false,
    this.formStatus = FormStatus.invalid,
    this.passwordReveal = false,
    this.twoFactor = false,
    this.pin1 = const Pin.pure(),
    this.pin2 = const Pin.pure(),
    this.pin3 = const Pin.pure(),
    this.pin4 = const Pin.pure(),
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    GlobalKey<FormState>? formKey,
    bool? isValid,
    FormStatus? formStatus,
    bool? passwordReveal,
    bool? twoFactor,
    Pin? pin1,
    Pin? pin2,
    Pin? pin3,
    Pin? pin4,
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
