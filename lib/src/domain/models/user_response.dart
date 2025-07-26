import 'dart:convert';
import 'package:indrive_flutter_client/src/domain/models/index.dart';

UserResponse authResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String authResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse extends ResponseApi {
  String? token;
  User? user;

  UserResponse({required super.ok, required super.msg, this.token, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      ok: json["ok"],
      msg: json["msg"],
      token: json['token'] != null ? json["token"] : null,
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "msg": msg,
    "token": token,
    "user": user?.toJson(),
  };
}
