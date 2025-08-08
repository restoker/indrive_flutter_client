import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class SaveSessionUseCase {
  final AuthRepository authRepository;

  SaveSessionUseCase({required this.authRepository});

  run(UserResponse userResponse) {
    return authRepository.saveUserSession(userResponse);
  }
}
