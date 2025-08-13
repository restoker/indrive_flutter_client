import 'package:indrive_flutter_client/src/data/DataSource/local/shared_preferences.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/user_services.dart';
import 'package:indrive_flutter_client/src/data/repository/auth_repository_impl.dart';
import 'package:indrive_flutter_client/src/data/repository/users_repository_impl.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/auth_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/get_session_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/login_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/logout_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/register_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/auth/save_session_use_case.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/user/update_user_usecase.dart';
import 'package:indrive_flutter_client/src/domain/UseCases/user/user_use_cases.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';
import 'package:indrive_flutter_client/src/domain/repository/users_repository.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  Future<String> get token async {
    final user = await sharedPref.read('user');
    if (user != null) {
      UserResponse response = UserResponse.fromJson(user);
      if (response.ok) return response.token!;
      return '';
    } else {
      return '';
    }
  }

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
    logOut: LogOutUseCase(authRepository: authRepository),
  );

  @injectable
  UserServices get userServices => UserServices(token: token);

  @injectable
  UsersRepository get userRepository =>
      UsersRepositoryImpl(userServices: userServices);

  @injectable
  UserUseCases get userUseCases => UserUseCases(
    updateUser: UpdateUserUsecase(usersRepository: userRepository),
  );
}
