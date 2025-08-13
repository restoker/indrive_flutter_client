import 'dart:io';

import 'package:indrive_flutter_client/src/domain/repository/users_repository.dart';

class UpdateUserUsecase {
  UsersRepository usersRepository;
  UpdateUserUsecase({required this.usersRepository});

  run(
    String id,
    String? nombre,
    String? email,
    String? telefono,
    String? password,
    File? image,
  ) {
    return usersRepository.updateUser(
      id,
      nombre,
      email,
      telefono,
      password,
      image,
    );
  }
}
