import 'dart:io';

import 'package:indrive_flutter_client/src/data/DataSource/remote/services/user_services.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/repository/users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  UserServices userServices;
  UsersRepositoryImpl({required this.userServices});

  @override
  Future<UserResponse> updateUser(
    String id,
    String? nombre,
    String? email,
    String? telefono,
    String? password,
    File? image,
  ) {
    return userServices.updateUser(
      id,
      nombre,
      email,
      telefono,
      password,
      image,
    );
  }
}
