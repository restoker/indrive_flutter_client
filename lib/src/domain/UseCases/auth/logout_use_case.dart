import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  Future<bool> run() async {
    return await authRepository.logout();
  }
}
