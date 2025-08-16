import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/user/user_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/models/index.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/presentation/utils/bloc_form_item.dart';

part 'profile_update_event.dart';
part 'profile_update_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  final UserUseCases userUseCases;
  final AuthUseCases authUseCases;
  final formKey = GlobalKey<FormState>();

  ProfileUpdateBloc({required this.userUseCases, required this.authUseCases})
    : super(ProfileUpdateInitial()) {
    on<ProfileUpdateInitEvent>(_profileUpdateInitEvent);

    on<NameChangeEvent>(_nameChangeEvent);

    on<PhoneChangeEvent>(_phoneChangeEvent);

    on<PasswordEvent>(_passwordChangeEvent);

    on<NewPasswordEvent>(_newPasswordChangeEvent);

    on<PickImageEvent>(_pickImageEvent);

    on<TakePhotoEvent>(_takePhotoEvent);

    on<UpdateFormSubmit>(_updateFormSubmit);

    on<UpdateUserSesion>(_updateUserSesion);
  }

  _profileUpdateInitEvent(ProfileUpdateInitEvent event, emit) {
    emit(
      state.copyWith(
        nombre: BlocFormItem(value: event.user?.nombre ?? ''),
        telefono: BlocFormItem(value: event.user?.telefono ?? ''),
        email: BlocFormItem(value: event.user?.email ?? ''),
        password: BlocFormItem(value: ''),
        newPassword: BlocFormItem(value: ''),
        formkey: formKey,
      ),
    );
  }

  _nameChangeEvent(NameChangeEvent event, emit) {
    emit(
      state.copyWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: validateNamePatter(event.nombre.value),
        ),
        formkey: formKey,
      ),
    );
  }

  _phoneChangeEvent(PhoneChangeEvent event, emit) {
    emit(
      state.copyWith(
        telefono: BlocFormItem(
          value: event.telefono.value,
          error: validatePhonePatter(event.telefono.value),
        ),
        formkey: formKey,
      ),
    );
  }

  _passwordChangeEvent(PasswordEvent event, emit) {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: validatePasswordPatter(
            event.password.value,
            state.newPassword.value,
          ),
        ),
        formkey: formKey,
      ),
    );
    emit(
      state.copyWith(
        newPassword: BlocFormItem(
          value: state.newPassword.value,
          error: validateNewPasswordPatter(
            state.newPassword.value,
            event.password.value,
          ),
        ),
      ),
    );
  }

  _newPasswordChangeEvent(NewPasswordEvent event, emit) {
    emit(
      state.copyWith(
        newPassword: BlocFormItem(
          value: event.newPassword.value,
          error: validateNewPasswordPatter(
            event.newPassword.value,
            state.password.value,
          ),
        ),
      ),
    );
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: state.password.value,
          error: validatePasswordPatter(
            state.password.value,
            event.newPassword.value,
          ),
        ),
      ),
    );
  }

  _pickImageEvent(PickImageEvent event, emit) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(
        state.copyWith(
          image: File(image.path),
          formkey: formKey,
          // loading: true,
        ),
      );
    }
  }

  _takePhotoEvent(TakePhotoEvent event, emit) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(
        state.copyWith(
          image: File(image.path),
          formkey: formKey,
          // loading: true,
        ),
      );
    }
  }

  _updateFormSubmit(UpdateFormSubmit event, emit) async {
    emit(state.copyWith(loading: true));
    UserResponse response = await userUseCases.updateUser.run(
      event.id,
      state.nombre.value,
      state.email.value,
      state.telefono.value,
      state.password.value,
      state.image,
    );
    if (response.ok) {
      emit(state.copyWith(loading: false, response: response));
    } else {
      emit(state.copyWith(loading: false));
    }
  }

  _updateUserSesion(UpdateUserSesion event, emit) async {
    UserResponse authResponse = await authUseCases.getSession.run();
    if (authResponse.ok) {
      authResponse.user!.nombre = event.user.nombre;
      authResponse.user!.telefono = event.user.telefono;
      authResponse.user!.image = event.user.image;
      await authUseCases.saveSession.run(authResponse);
    }
    emit(state.copyWith());
  }
}

String? validateNamePatter(String value) {
  if (value.isEmpty) {
    return 'El campo es obligatorio';
  } else if (value.length < 2) {
    return 'Debe ingresar un valor mas descriptivo';
  } else if (value.length > 159) {
    return 'Ha sobre pasado el numero maximo de caracteres';
  }
  return null;
}

String? validatePhonePatter(String value) {
  if (value.isEmpty) {
    return 'El campo es obligatorio';
  } else if (int.parse(value).isNaN) {
    return 'El teléfono solo debe incluir numeros';
  } else if (value.length != 9) {
    return 'Su numero debe contener 9 digitos';
  }
  return null;
}

String? validatePasswordPatter(String value, String newPassword) {
  // inspect(newPassword);
  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  if (value.isEmpty) {
    return null;
  } else {
    if (!regex.hasMatch(value)) {
      return 'Ingrese un password valido';
    } else if (newPassword.isEmpty) {
      return 'Debe ingresar en nuevo password';
    } else if (value.length < 4) {
      return 'password no valido';
    } else {
      return null;
    }
  }
}

String? validateNewPasswordPatter(String value, String password) {
  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  if (value.isEmpty) {
    return null;
  } else {
    if (!regex.hasMatch(value)) {
      return 'Ingrese un password valido';
    } else if (password.isEmpty) {
      return 'Debe ingresar en nuevo password';
    } else if (value.length < 4) {
      return 'password no valido';
    } else if (value.length > 70) {
      return 'Ha sobrepasado el valor máximo de caracteres';
    } else {
      return null;
    }
  }
}
