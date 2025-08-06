import 'package:indrive_flutter_client/src/data/repository/auth_repository_impl.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository = AuthRepositoryImpl();

  run(String email, String password, {int? code}) {
    return authRepository.login(email, password, code: code);
  }
}
