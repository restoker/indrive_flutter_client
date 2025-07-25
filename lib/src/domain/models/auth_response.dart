import 'dart:convert';
import 'package:indrive_flutter_client/src/domain/models/responseapi.dart';
import 'package:indrive_flutter_client/src/domain/models/user.dart';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse extends ResponseApi {
  String? token;
  User? user;

  AuthResponse({super.ok, super.msg, this.token, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      ok: json["ok"] ?? false,
      msg: json["msg"] ?? "",
      token: json['token'] != null ? json["token"] : null,
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "ok": ok ?? false,
    "msg": msg ?? "",
    "token": token,
    "user": user?.toJson(),
  };
}
