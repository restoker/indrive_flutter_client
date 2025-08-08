import 'package:indrive_flutter_client/src/data/DataSource/local/shared_preferences.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/data/repository/auth_repository_impl.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/get_session_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/login_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/register_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/save_session_use_case.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService: authService, sharedPref: sharedPref);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository: authRepository),
    register: RegisterUseCase(authRepository: authRepository),
    saveSession: SaveSessionUseCase(authRepository: authRepository),
    getSession: GetSessionUseCase(authRepository: authRepository),
  );
}
