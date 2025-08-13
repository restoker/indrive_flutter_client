import 'dart:io';

import 'package:indrive_flutter_client/src/domain/models/user_response.dart';

abstract class UsersRepository {
  Future<UserResponse> updateUser(
    String id,
    String? nombre,
    String? email,
    String? telefono,
    String? password,
    File? image,
  );
}
