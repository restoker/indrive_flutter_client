import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/infra/inputs/inputs.dart';

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

    on<LoginSubmitEvent>(
      (event, emit) => _loginSubmit(event, emit, authService),
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
      if (!responseApi.ok) {}
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

  void _togglePassword(TogglePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(passwordReveal: !state.passwordReveal));
  }
}
