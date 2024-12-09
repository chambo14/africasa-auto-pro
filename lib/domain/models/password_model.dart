import 'package:meta/meta.dart';
import 'dart:convert';

class PasswordModel {
  final bool? success;
  final Data? data;
  final String? message;

  PasswordModel({
     this.success,
     this.data,
     this.message,
  });

  PasswordModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      PasswordModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory PasswordModel.fromRawJson(String str) => PasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final User user;
  final String? token;

  Data({
    required this.user,
    required this.token,
  });

  Data copyWith({
    User? user,
    String? token,
  }) =>
      Data(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  final int? id;
  final String? reference;
  final String? typeUser;
  final String? name;
  final String? lastname;
  final String? email;
  final String? contact;
  final dynamic emailVerifiedAt;
  final int? isActive;
  final int? isBanned;
  final int? isValidated;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final int connections;
  final dynamic profilPic;

  User({
    required this.id,
    required this.reference,
    required this.typeUser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    required this.emailVerifiedAt,
    required this.isActive,
    required this.isBanned,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.connections,
    required this.profilPic,
  });

  User copyWith({
    int? id,
    String? reference,
    String? typeUser,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    dynamic emailVerifiedAt,
    int? isActive,
    int? isBanned,
    int? isValidated,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    int? connections,
    dynamic profilPic,
  }) =>
      User(
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "connections": connections,
    "profil_pic": profilPic,
  };
}
