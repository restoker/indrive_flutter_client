import 'package:indrive_flutter_client/src/data/repository/auth_repository_impl.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository = AuthRepositoryImpl();

  // RegisterUseCase({required this.authRepository});

  run(String nombre, String email, String telefono, String password) {
    return authRepository.registro(nombre, email, telefono, password);
  }
}
