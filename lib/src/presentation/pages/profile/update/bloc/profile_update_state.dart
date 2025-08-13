part of 'profile_update_bloc.dart';

enum ProfileUpdateStatus { initial, loading, success, failure }

class ProfileUpdateState extends Equatable {
  final BlocFormItem nombre;
  final BlocFormItem email;
  final BlocFormItem telefono;
  final BlocFormItem password;
  final BlocFormItem newPassword;
  final GlobalKey<FormState>? formkey;
  final bool loading;
  final File? image;
  final UserResponse? response;
  final ProfileUpdateStatus status;
  // final PermissionStatus camara;
  const ProfileUpdateState({
    this.nombre = const BlocFormItem(),
    this.email = const BlocFormItem(),
    this.telefono = const BlocFormItem(),
    this.password = const BlocFormItem(),
    this.newPassword = const BlocFormItem(),
    this.formkey,
    this.loading = false,
    this.image,
    this.response,
    this.status = ProfileUpdateStatus.initial,
    // this.camara = PermissionStatus.denied,
  });

  ProfileUpdateState copyWith({
    BlocFormItem? nombre,
    BlocFormItem? email,
    BlocFormItem? telefono,
    BlocFormItem? password,
    BlocFormItem? newPassword,
    GlobalKey<FormState>? formkey,
    bool? loading,
    File? image,
    UserResponse? response,
    ProfileUpdateStatus? status,
    // PermissionStatus? camara,
  }) {
    return ProfileUpdateState(
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      formkey: formkey ?? this.formkey,
      loading: loading ?? this.loading,
      image: image ?? this.image,
      response: response ?? this.response,
      status: status ?? this.status,
      // camara: camara ?? this.camara,
    );
  }

  @override
  List<Object> get props => [
    nombre,
    email,
    telefono,
    password,
    newPassword,
    loading,
    status,
    // camara,
  ];
}

final class ProfileUpdateInitial extends ProfileUpdateState {}
