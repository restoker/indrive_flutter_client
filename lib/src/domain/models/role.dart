enum RoleName {
  superadmin('superadmin'),
  admin('admin'),
  client('client'),
  driver('driver');

  final String value;

  const RoleName(this.value);
}

class Role {
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  RoleName name;
  String image;
  String route;

  Role({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.image,
    required this.route,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    name: RoleName.values.firstWhere((e) => e.value == json["name"]),
    image: json["image"],
    route: json["route"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "name": name.value,
    "image": image,
    "route": route,
  };
}
