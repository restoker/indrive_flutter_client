import 'package:indrive_flutter_client/src/domain/UseCases/auth/login_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/register_use_case.dart';

class AuthUseCases {
  final LoginUseCase login;
  final RegisterUseCase register;

  AuthUseCases({required this.login, required this.register});
}
