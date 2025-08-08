import 'package:indrive_flutter_client/src/data/DataSource/local/shared_preferences.dart';
import 'package:indrive_flutter_client/src/data/DataSource/remote/services/auth_services.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  final SharedPref sharedPref;

  AuthRepositoryImpl({required this.authService, required this.sharedPref});

  @override
  Future<UserResponse> login(String email, String password, {int? code}) {
    return authService.login(email, password, code: code);
  }

  @override
  Future<UserResponse> registro(
    String nombre,
    String email,
    String telefono,
    String password,
  ) {
    return authService.registro(nombre, email, telefono, password);
  }

  @override
  Future<void> saveUserSession(UserResponse userResponse) async {
    return await sharedPref.save('user', userResponse.toJson());
  }

  @override
  Future<UserResponse?> getUserSession() async {
    final result = await sharedPref.read('user');
    if (result != null) {
      return UserResponse.fromJson(result);
    }
    return null;
  }

  @override
  Future<bool> removeUserSession() async {
    final result = await sharedPref.remove('user');
    return result;
  }
}
