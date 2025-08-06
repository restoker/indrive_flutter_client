import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  run(String email, String password, {int? code}) {
    return authRepository.login(email, password, code: code);
  }
}
