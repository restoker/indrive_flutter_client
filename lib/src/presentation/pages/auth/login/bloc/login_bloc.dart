// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/login_use_case.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/infra/inputs/inputs.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final formKey = GlobalKey<FormState>();
  final AuthUseCases authUseCases;
  LoginBloc(this.authUseCases) : super(LoginState()) {
    // final authService = AuthService();

    on<LoginInitEvent>((event, emit) async {
      emit(state.copyWith(formKey: formKey));
      UserResponse? session = await authUseCases.getSession.run();
      if (session != null) {
        emit(state.copyWith(formStatus: FormStatus.valid));
      } else {
        emit(state.copyWith(formStatus: FormStatus.invalid));
      }
    });

    on<EmailChanged>(_emailChanged);

    on<PasswordChanged>(_passwordChanged);

    on<Ping1Changed>(_ping1Changed);

    on<Ping2Changed>(_ping2Changed);

    on<Ping3Changed>(_ping3Changed);

    on<Ping4Changed>(_ping4Changed);

    on<LoginSubmitEvent>(
      (event, emit) => _loginSubmit(event, emit, authUseCases.login),
    );

    on<LoginSubmitTwoFactorEvent>(
      (event, emit) => _loginSubmitTwoFactor(event, emit, authUseCases.login),
    );

    on<TogglePasswordEvent>(_togglePassword);

    on<FormReset>((event, emit) => _formReset(event, emit));

    on<SaveSessionEvent>(_saveSession);
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
    LoginUseCase loginUseCase,
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
      UserResponse responseApi = await loginUseCase.run(
        state.email.value,
        state.password.value,
      );
      // inspect(responseApi);
      if (responseApi.ok) {
        // verificar si tiene activado el dos factores
        if (!responseApi.user!.twoFactor) {
          emit(state.copyWith(formStatus: FormStatus.valid));
          emit(state.copyWith(userResponse: responseApi));
          // redirigir al usuario a la pantalla principal y reiniciar el formulario
        } else {
          // Enviar el codigo al correo electrónico
          emit(state.copyWith(twoFactor: true));
          // Guardar en shared preferences
        }
      } else {
        emit(state.copyWith(formStatus: FormStatus.error));
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
    LoginUseCase loginUseCase,
  ) async {
    if (state.pin1 == 10 ||
        state.pin2 == 10 ||
        state.pin3 == 10 ||
        state.pin4 == 10 ||
        state.pin1.isNaN ||
        state.pin2.isNaN ||
        state.pin3.isNaN ||
        state.pin4.isNaN) {
      emit(state.copyWith(formStatus: FormStatus.error));
      emit(state.copyWith(formStatus: FormStatus.invalid));
    } else {
      // enviar codigo
      final code =
          state.pin1 * 1000 + state.pin2 * 100 + state.pin3 * 10 + state.pin4;
      UserResponse responseApi = await loginUseCase.run(
        state.email.value,
        state.password.value,
        code: code,
      );
      if (responseApi.ok) {
        emit(state.copyWith(formStatus: FormStatus.valid));
        emit(state.copyWith(userResponse: responseApi));
        // reinciar formulario
        // emit(state.copyWith(formStatus: FormStatus.invalid));
        state.formKey?.currentState?.reset();
      } else {
        emit(state.copyWith(formStatus: FormStatus.error));
      }
    }
  }

  void _togglePassword(TogglePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordReveal: !state.passwordReveal));
  }

  void _formReset(FormReset? event, Emitter<LoginState>? emit) {
    emit!(state.copyWith(formStatus: FormStatus.invalid));
    state.formKey?.currentState?.reset();
  }

  void _saveSession(SaveSessionEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormStatus.validating));
    await authUseCases.saveSession.run(event.userResponse);
    emit(state.copyWith(formStatus: FormStatus.valid));
  }
}
