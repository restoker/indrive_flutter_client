part of 'profile_update_bloc.dart';

class ProfileUpdateState extends Equatable {
  final BlocFormItem fullname;
  final BlocFormItem email;
  final BlocFormItem phone;
  final BlocFormItem password;
  final BlocFormItem newPassword;
  final GlobalKey<FormState>? formkey;
  final bool loading;
  final File? image;
  final UserResponse? response;
  // final PermissionStatus camara;
  const ProfileUpdateState({
    this.fullname = const BlocFormItem(),
    this.email = const BlocFormItem(),
    this.phone = const BlocFormItem(),
    this.password = const BlocFormItem(),
    this.newPassword = const BlocFormItem(),
    this.formkey,
    this.loading = false,
    this.image,
    this.response,
    // this.camara = PermissionStatus.denied,
  });

  ProfileUpdateState copyWith({
    BlocFormItem? fullname,
    BlocFormItem? email,
    BlocFormItem? phone,
    BlocFormItem? password,
    BlocFormItem? newPassword,
    GlobalKey<FormState>? formkey,
    bool? loading,
    File? image,
    UserResponse? response,
    // PermissionStatus? camara,
  }) {
    return ProfileUpdateState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      formkey: formkey ?? this.formkey,
      loading: loading ?? this.loading,
      image: image ?? this.image,
      response: response ?? this.response,
      // camara: camara ?? this.camara,
    );
  }

  @override
  List<Object> get props => [
    fullname,
    email,
    phone,
    password,
    newPassword,
    loading,
    // camara,
  ];
}

final class ProfileUpdateInitial extends ProfileUpdateState {}
