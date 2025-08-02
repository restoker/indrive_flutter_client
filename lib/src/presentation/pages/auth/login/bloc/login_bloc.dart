import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/infra/inputs/inputs.dart';
import 'package:indrive_flutter_client/src/infra/inputs/pin.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    final formKey = GlobalKey<FormState>();
    final authService = AuthService();

    on<LoginInitEvent>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<EmailChanged>(_emailChanged);

    on<PasswordChanged>(_passwordChanged);

    on<Ping1Changed>(_ping1Changed);

    on<Ping2Changed>(_ping2Changed);

    on<Ping3Changed>(_ping3Changed);

    on<Ping4Changed>(_ping4Changed);

    on<LoginSubmitEvent>(
      (event, emit) => _loginSubmit(event, emit, authService),
    );

    on<LoginSubmitTwoFactorEvent>(
      (event, emit) => _loginSubmitTwoFactor(event, emit, authService),
    );

    on<TogglePasswordEvent>(_togglePassword);
  }

  void _emailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  void _ping1Changed(Ping1Changed event, Emitter<LoginState> emit) {
    emit(state.copyWith(pin1: event.pin1));
  }

  void _ping2Changed(Ping2Changed event, Emitter<LoginState> emit) {
    emit(state.copyWith(pin2: event.pin2));
  }

  void _ping3Changed(Ping3Changed event, Emitter<LoginState> emit) {
    emit(state.copyWith(pin3: event.pin3));
  }

  void _ping4Changed(Ping4Changed event, Emitter<LoginState> emit) {
    emit(state.copyWith(pin4: event.pin4));
  }

  void _loginSubmit(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
    AuthService authService,
  ) async {
    emit(
      state.copyWith(
        email: Email.dirty(state.email.value),
        password: Password.dirty(state.password.value),
        isValid: Formz.validate([state.email, state.password]),
        formStatus: FormStatus.validating,
      ),
    );

    if (state.isValid) {
      UserResponse responseApi = await authService.login(
        state.email.value,
        state.password.value,
      );
      // inspect(responseApi);
      if (responseApi.ok) {
        // verificar si tiene activado el dos factores
        if (responseApi.user!.twoFactor == true) {
          // Enviar el codigo al correo electrónico
          emit(state.copyWith(twoFactor: true));
        } else {
          emit(state.copyWith(formStatus: FormStatus.invalid));
          // Guardar en shared preferences
        }
      }
      // .then((value) {
      //   emit(state.copyWith(formStatus: FormStatus.valid));
      // })
      // .catchError((error) {
      //   emit(state.copyWith(formStatus: FormStatus.invalid));
      // });
      // inspect(state);
    } else {
      // mostrar mensaje de error
      emit(state.copyWith(formStatus: FormStatus.invalid));
    }
  }

  void _loginSubmitTwoFactor(
    LoginSubmitTwoFactorEvent event,
    Emitter<LoginState> emit,
    AuthService authService,
  ) {
    if (state.pin1 == 10 ||
        state.pin2 == 10 ||
        state.pin3 == 10 ||
        state.pin4 == 10) {
      emit(state.copyWith(formStatus: FormStatus.error));
      emit(state.copyWith(formStatus: FormStatus.invalid));
    } else {
      // enviar codigo
      inspect(state.pin1);
      inspect(state.pin2);
      inspect(state.pin3);
      inspect(state.pin4);
      emit(state.copyWith(formStatus: FormStatus.valid));
    }
  }

  void _togglePassword(TogglePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordReveal: !state.passwordReveal));
  }
}
