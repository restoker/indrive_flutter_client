import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class GetSessionUseCase {
  final AuthRepository authRepository;

  GetSessionUseCase({required this.authRepository});

  run() {
    return authRepository.getUserSession();
  }
}
