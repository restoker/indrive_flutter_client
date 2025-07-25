import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';
import 'package:http/http.dart' as http;
import 'package:indrive_flutter_client/src/data/api/api_config.dart';

class AuthService {
  Future<dynamic> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.ipServer, '/users/login');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      String body = json.encode({'email': email, 'password': password});

      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        throw Exception('Bad Request');
      } else if (response.statusCode == 500) {
        throw Exception('Internal Server Error');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found');
      } else {
        throw Exception('Failed to load data');
      }
    } on Exception catch (e) {
      inspect(e);
      throw Exception(e);
    }
  }
}
