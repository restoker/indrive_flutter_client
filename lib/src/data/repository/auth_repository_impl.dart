import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final authService = AuthService();

  @override
  Future<UserResponse> login(String email, String password, {int? code}) {
    return authService.login(email, password, code: code);
  }

  @override
  Future<UserResponse> registro(
    String nombre,
    String email,
    String telefono,
    String password,
  ) {
    return authService.registro(nombre, email, telefono, password);
  }
}
