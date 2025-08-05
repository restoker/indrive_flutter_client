import 'package:indrive_flutter_client/src/domain/models/role.dart';

class User {
  String? id;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  String nombre;
  String email;
  String telefono;
  String? image;
  String? password;
  bool? verified;
  bool? isActive;
  String? notificationToken;
  List<Role?>? roles;
  bool twoFactor;

  User({
    this.id,
    // this.createdAt,
    // this.updatedAt,
    required this.nombre,
    required this.email,
    required this.telefono,
    this.image,
    this.password,
    this.verified,
    this.isActive,
    this.notificationToken,
    this.roles,
    this.twoFactor = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // inspect(json['verificated']);
    return User(
      id: json["id"],
      // createdAt: DateTime.parse(json["createdAt"]),
      // updatedAt: DateTime.parse(json["updatedAt"]),
      nombre: json["nombre"],
      email: json["email"],
      telefono: json["telefono"],
      image: json["image"],
      password: json["password"],
      verified: json["verified"],
      isActive: json["isActive"],
      notificationToken: json["notification_token"],
      roles: json["roles"] != null
          ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
          : [],
      twoFactor: json['two_factor_enabled'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    // "createdAt": createdAt?.toIso8601String(),
    // "updatedAt": updatedAt?.toIso8601String(),
    "nombre": nombre,
    "email": email,
    "telefono": telefono,
    "image": image,
    "password": password,
    "verified": verified,
    "isActive": isActive,
    "notification_token": notificationToken,
    "roles": roles != null
        ? List<dynamic>.from(roles!.map((x) => x?.toJson()))
        : [],
    "two_factor_code": twoFactor,
  };
}
