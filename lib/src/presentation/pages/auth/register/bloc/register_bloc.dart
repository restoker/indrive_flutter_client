import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indrive_flutter_client/src/presentation/utils/bloc_form_item.dart';

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
    emit(state.copyWith(formStatus: FormStatus.validating));
    emit(state.copyWith(formStatus: FormStatus.valid));
    // inspect(state.telefono.value);
    // inspect(state.email.value);
    // inspect(state.password.value);
    // inspect(state.confirmarPassword.value);
    // if (state.isValid) {
    //   _formReset(null, null);
    // } else {
    //   emit(state.copyWith(formStatus: FormStatus.invalid));
    // }
  }

  void _emailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isEmpty || event.email.value.trim().isEmpty
              ? 'El email es obligatorio'
              : (!emailRegExp.hasMatch(event.email.value))
              ? 'Ingrese un email valido'
              : null,
        ),
        formKey: state.formKey,
      ),
    );
  }

  void _nombreChanged(
    RegisterNombreChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: event.nombre.value.isEmpty || event.nombre.value.trim().isEmpty
              ? 'El nombre es obligatorio'
              : event.nombre.value.length < 2
              ? 'Ingrese un nombre mas descriptivo'
              : event.nombre.value.length > 150
              ? 'Sobrepaso el máximo de caracteres'
              : null,
        ),
        formKey: state.formKey,
      ),
    );
  }

  void _telefonoChanged(
    RegisterTelefonoChanged event,
    Emitter<RegisterState> emit,
  ) {
    String? dato = event.telefono.value;
    final RegExp telefonoRegExp = RegExp(r'^(9|7)\d{8}$');
    emit(
      state.copyWith(
        telefono: BlocFormItem(
          value: dato,
          error: dato.isEmpty || dato.trim().isEmpty
              ? 'El teléfono es obligatorio'
              : dato.length != 9
              ? 'Ingrese un número válido'
              : int.parse(dato).isNaN
              ? 'El teléfono solo debe incluir números'
              : !telefonoRegExp.hasMatch(dato)
              ? 'Número de teléfono inválido en Perú'
              : null,
        ),
        formKey: state.formKey,
      ),
    );
  }

  void _passwordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error:
              event.password.value.isEmpty ||
                  event.password.value.trim().isEmpty
              ? 'El password es obligatorio'
              : event.password.value.length < 5
              ? 'El password debe tener al menos 5 caracteres'
              : null,
        ),
        formKey: state.formKey,
      ),
    );

    emit(
      state.copyWith(
        confirmarPassword: BlocFormItem(
          value: state.confirmarPassword.value,
          error:
              state.confirmarPassword.value.isEmpty ||
                  state.confirmarPassword.value.trim().isEmpty
              ? 'Confirmar es obligatoio'
              : state.confirmarPassword.value != state.password.value
              ? 'Confirmar debe ser igual a password'
              : state.confirmarPassword.value.length < 5
              ? 'El Confirmar debe tener al menos 5 caracteres'
              : null,
        ),
        formKey: state.formKey,
      ),
    );
  }

  void _confirmarPasswordChanged(
    RegisterConfirmarPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        confirmarPassword: BlocFormItem(
          value: event.confirmarPassword.value,
          error:
              event.confirmarPassword.value.isEmpty ||
                  event.confirmarPassword.value.trim().isEmpty
              ? 'Confirmar es obligatoio'
              : event.confirmarPassword.value != state.password.value
              ? 'El Confirmar debe ser igual a password'
              : event.confirmarPassword.value.length < 5
              ? 'El Confirmar debe tener al menos 5 caracteres'
              : null,
        ),
        formKey: state.formKey,
      ),
    );

    emit(
      state.copyWith(
        password: BlocFormItem(
          value: state.password.value,
          error:
              state.password.value.isEmpty ||
                  state.password.value.trim().isEmpty
              ? 'El password es obligatorio'
              : state.password.value.length < 5
              ? 'El password debe tener al menos 5 caracteres'
              : null,
        ),
        formKey: state.formKey,
      ),
    );
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
    emit!(state.copyWith(formStatus: FormStatus.invalid));
    state.formKey?.currentState?.reset();
  }
}
