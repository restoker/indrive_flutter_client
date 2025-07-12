import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:indrive_flutter_client/src/infra/inputs/inputs.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    final formKey = GlobalKey<FormState>();

    on<RegisterInitEvent>((event, emit) {
      emit(state.copyWith(formKey: formKey));
    });

    on<RegisterSubmit>(_registerSubmit);

    on<RegisterEmailChanged>(_emailChanged);

    on<RegisterPasswordChanged>(_passwordChanged);

    on<RegisterConfirmarPasswordChanged>(_confirmarPasswordChanged);

    on<RegisterNombreChanged>(_nombreChanged);

    on<RegisterTelefonoChanged>(_telefonoChanged);

    on<TogglePasswordEvent>(_togglePassword);

    on<ToggleConfirmarPasswordEvent>(_toggleConfirmarPassword);

    on<FormReset>((event, emit) => _formReset(event, emit));
  }

  void _registerSubmit(RegisterSubmit event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
        email: Email.dirty(state.email.value),
        nombre: Nombre.dirty(state.nombre.value),
        telefono: Telefono.dirty(state.telefono.value),
        password: PasswordRegister.dirty(
          value: state.password.value,
          confirmPassword: state.confirmarPassword.value,
        ),
        confirmarPassword: ConfirmarPassword.dirty(
          value: state.confirmarPassword.value,
          password: state.password.value,
        ),
        isValid: Formz.validate([
          state.email,
          state.password,
          state.confirmarPassword,
          state.nombre,
          state.telefono,
        ]),
        formStatus: FormStatus.validating,
      ),
    );

    if (state.isValid) {
      inspect(state);
      _formReset(null, null);
    } else {
      emit(state.copyWith(formStatus: FormStatus.invalid));
    }
  }

  void _emailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.password,
          state.confirmarPassword,
          state.nombre,
          state.telefono,
        ]),
      ),
    );
  }

  void _nombreChanged(
    RegisterNombreChanged event,
    Emitter<RegisterState> emit,
  ) {
    final nombre = Nombre.dirty(event.nombre);
    emit(
      state.copyWith(
        nombre: nombre,
        isValid: Formz.validate([
          state.email,
          state.password,
          nombre,
          state.telefono,
          state.confirmarPassword,
        ]),
      ),
    );
  }

  void _telefonoChanged(
    RegisterTelefonoChanged event,
    Emitter<RegisterState> emit,
  ) {
    final telefono = Telefono.dirty(event.telefono);
    emit(
      state.copyWith(
        telefono: telefono,
        isValid: Formz.validate([
          state.email,
          state.password,
          telefono,
          state.confirmarPassword,
          state.nombre,
        ]),
      ),
    );
  }

  void _passwordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = PasswordRegister.dirty(
      value: event.password,
      confirmPassword: state.confirmarPassword.value,
    );

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.email,
          password,
          state.confirmarPassword,
          state.nombre,
          state.telefono,
        ]),
      ),
    );

    // if (!state.confirmarPassword.isPure) {
    //   emit(
    //     state.copyWith(
    //       confirmarPassword: ConfirmarPassword.dirty(
    //         password: event.password,
    //         value: state.confirmarPassword.value,
    //       ),
    //       isValid: Formz.validate([
    //         state.email,
    //         password,
    //         state.confirmarPassword,
    //         state.nombre,
    //         state.telefono,
    //       ]),
    //     ),
    //   );
    // }
  }

  void _confirmarPasswordChanged(
    RegisterConfirmarPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final confirmarPassword = ConfirmarPassword.dirty(
      value: event.confirmarPassword,
      password: state.password.value,
    );

    emit(
      state.copyWith(
        confirmarPassword: confirmarPassword,
        isValid: Formz.validate([
          state.email,
          state.password,
          confirmarPassword,
          state.nombre,
          state.telefono,
        ]),
      ),
    );
    if (!state.password.isPure) {
      emit(
        state.copyWith(
          password: PasswordRegister.dirty(
            value: state.password.value,
            confirmPassword: event.confirmarPassword,
          ),
          isValid: Formz.validate([
            state.email,
            state.password,
            confirmarPassword,
            state.nombre,
            state.telefono,
          ]),
        ),
      );
    }
  }

  void _togglePassword(TogglePasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(passwordReveal: !state.passwordReveal));
  }

  void _toggleConfirmarPassword(
    ToggleConfirmarPasswordEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(confirmarPasswordReveal: !state.confirmarPasswordReveal),
    );
  }

  void _formReset(FormReset? event, Emitter<RegisterState>? emit) {
    state.formKey?.currentState?.reset();
    // emit(state.copyWith(formStatus: FormStatus.initial));
  }
}
