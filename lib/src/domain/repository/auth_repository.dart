import 'package:indrive_flutter_client/src/domain/models/user_response.dart';

abstract class AuthRepository {
  Future<UserResponse> login(String email, String password, {int? code});
  Future<UserResponse> registro(
    String nombre,
    String email,
    String telefono,
    String password,
  );
}
