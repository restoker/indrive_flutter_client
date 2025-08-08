import 'package:indrive_flutter_client/src/domain/UseCases/auth/get_session_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/login_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/register_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/save_session_use_case.dart';

class AuthUseCases {
  final LoginUseCase login;
  final RegisterUseCase register;
  final SaveSessionUseCase saveSession;
  final GetSessionUseCase getSession;

  AuthUseCases({
    required this.login,
    required this.register,
    required this.saveSession,
    required this.getSession,
  });
}
