part of 'profile_update_bloc.dart';

abstract class ProfileUpdateEvent {
  const ProfileUpdateEvent();
}

class ProfileUpdateInitEvent extends ProfileUpdateEvent {
  late User? user;
  ProfileUpdateInitEvent({required this.user});
}

class NameChangeEvent extends ProfileUpdateEvent {
  final BlocFormItem nombre;
  NameChangeEvent({required this.nombre});
}

class EmailChangeEvent extends ProfileUpdateEvent {
  final BlocFormItem email;
  EmailChangeEvent({required this.email});
}

class PhoneChangeEvent extends ProfileUpdateEvent {
  final BlocFormItem telefono;
  PhoneChangeEvent({required this.telefono});
}

class PasswordEvent extends ProfileUpdateEvent {
  final BlocFormItem password;
  PasswordEvent({required this.password});
}

class NewPasswordEvent extends ProfileUpdateEvent {
  final BlocFormItem newPassword;
  NewPasswordEvent({required this.newPassword});
}

class UpdateUserSesion extends ProfileUpdateEvent {
  final User user;
  UpdateUserSesion({required this.user});
}

class PickImageEvent extends ProfileUpdateEvent {}

class TakePhotoEvent extends ProfileUpdateEvent {}

class UpdateFormSubmit extends ProfileUpdateEvent {
  final String id;
  UpdateFormSubmit({required this.id});
}
