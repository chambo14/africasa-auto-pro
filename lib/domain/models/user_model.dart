import 'dart:convert';

class UserModel {
  final bool? success;
  final Data? data;
  final String? message;

  UserModel({
    this.success,
    this.data,
    this.message,
  });

  UserModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      UserModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int id;
  final String reference;
  final String typeUser;
  final String name;
  final String lastname;
  final String email;
  final String contact;
  final String? emailVerifiedAt;  // Nullable String
  final int isActive;
  final int isBanned;
  final int isValidated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;  // Nullable String
  final int connections;
  final String? profilPic;

  Data({
    required this.id,
    required this.reference,
    required this.typeUser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    this.emailVerifiedAt,
    required this.isActive,
    required this.isBanned,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.connections,
    required this.profilPic,
  });

  Data copyWith({
    int? id,
    String? reference,
    String? typeUser,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    String? emailVerifiedAt,
    int? isActive,
    int? isBanned,
    int? isValidated,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? connections,
    String? profilPic,
  }) =>
      Data(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        typeUser: typeUser ?? this.typeUser,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        isActive: isActive ?? this.isActive,
        isBanned: isBanned ?? this.isBanned,
        isValidated: isValidated ?? this.isValidated,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        connections: connections ?? this.connections,
        profilPic: profilPic ?? this.profilPic,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    reference: json["reference"],
    typeUser: json["type_user"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    contact: json["contact"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    isBanned: json["is_banned"],
    isValidated: json["is_validated"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    connections: json["connections"],
    profilPic: json["profil_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "type_user": typeUser,
    "name": name,
    "lastname": lastname,
    "email": email,
    "contact": contact,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive,
    "is_banned": isBanned,
    "is_validated": isValidated,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "connections": connections,
    "profil_pic": profilPic,
  };
}
