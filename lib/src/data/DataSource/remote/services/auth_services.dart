import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:indrive_flutter_client/src/data/api/api_config.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:indrive_flutter_client/src/domain/models/index.dart';

class AuthService {
  Future<UserResponse> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.ipServer, '/users/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['ok'] == true) {
          final userData = UserResponse.fromJson(data);
          inspect(userData);
          return userData;
        } else {
          return UserResponse(ok: false, msg: data['msg']);
        }
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request');
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found');
      } else {
        throw Exception('Failed to load data');
      }
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return UserResponse(ok: false, msg: 'Error en el tiempo de conexión');
    } on Exception catch (_) {
      // inspect(e);
      // throw Exception(e);
      return UserResponse(ok: false, msg: 'Error en la conexión al servidor');
    }
  }
}
