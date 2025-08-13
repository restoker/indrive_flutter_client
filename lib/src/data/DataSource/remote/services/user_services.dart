import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:indrive_flutter_client/src/data/api/api_config.dart';
import 'package:indrive_flutter_client/src/domain/models/user_response.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<String> token;

  UserServices({required this.token});

  Future<UserResponse> updateUser(
    String id,
    String? nombre,
    String? telefono,
    String? password,
    String? newPassword,
    File? file,
  ) async {
    try {
      Uri url = Uri.http(ApiConfig.ipServer, '/users/update/$id');

      if (file != null) {
        final request = http.MultipartRequest('PUT', url);
        request.headers['x-jwt'] = await token;
        request.files.add(
          http.MultipartFile(
            'file',
            http.ByteStream(file.openRead().cast()),
            await file.length(),
            filename: basename(file.path),
            contentType: MediaType('image', 'jpeg'),
          ),
        );
        request.fields['fullname'] = nombre ?? '';
        request.fields['phone'] = telefono ?? '';
        // request.fields['fullname'] = nombre ?? '';
        if (password!.isNotEmpty && newPassword!.isNotEmpty) {
          request.fields['password'] = password;
          request.fields['newPassword'] = newPassword;
        }
        final response = await request.send();
        // inspect(response);
        if (response.statusCode == 201) {
          final data = json.decode(
            await response.stream.transform(utf8.decoder).first,
          );
          // inspect(data);
          // if (data["ok"]) {
          final authResponse = UserResponse.fromJson(data);
          // final respuesta = SuccessResponse(authResponse);
          return authResponse;
        } else if (response.statusCode == 404) {
          return UserResponse(ok: false, msg: 'Server Not found');
        } else if (response.statusCode == 400) {
          return UserResponse(ok: false, msg: 'Error on data sended');
        } else if (response.statusCode == 500) {
          return UserResponse(ok: false, msg: 'Internal Server Error');
        } else {
          return UserResponse(ok: false, msg: 'Failed to load data');
        }
      } else {
        Map<String, String> headers = {
          'Content-Type': "application/json",
          'x-jwt': await token,
        };
        late String body;
        if (password!.isNotEmpty && newPassword!.isNotEmpty) {
          body = json.encode({
            'fullname': nombre,
            "phone": telefono,
            "password": password,
            "newPassword": newPassword,
          });
        } else {
          body = json.encode({'fullname': nombre, "phone": telefono});
        }
        final response = await http.put(url, headers: headers, body: body);
        if (response.statusCode == 201) {
          final data = json.decode(response.body);
          // inspect(data);
          // if (data["ok"]) {
          final authResponse = UserResponse.fromJson(data);
          // final respuesta = SuccessResponse(authResponse);
          return authResponse;
        } else if (response.statusCode == 404) {
          return UserResponse(ok: false, msg: 'Not found');
        } else if (response.statusCode == 400) {
          return UserResponse(ok: false, msg: 'Not found');
        } else {
          return UserResponse(ok: false, msg: 'Failed to load data');
        }
      }
      // final response = await http.put(url, headers: headers, body: body);
      // inspect(response);
    } on TimeoutException catch (_) {
      // A timeout occurred.
      return UserResponse(ok: false, msg: 'Error en el tiempo de conexión');
    } on Exception catch (_) {
      // inspect(e);
      return UserResponse(ok: false, msg: 'Error en la conexión al servidor');
    }
  }
}
