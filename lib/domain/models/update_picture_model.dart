import 'package:meta/meta.dart';
import 'dart:convert';

class UpdatePictureModel {
  final bool? success;
  final List<Datum>? data;
  final String? message;

  UpdatePictureModel({
     this.success,
     this.data,
     this.message,
  });

  UpdatePictureModel copyWith({
    bool? success,
    List<Datum>? data,
    String? message,
  }) =>
      UpdatePictureModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory UpdatePictureModel.fromRawJson(String str) => UpdatePictureModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdatePictureModel.fromJson(Map<String, dynamic> json) => UpdatePictureModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final int? connections;
  final dynamic profilPic;
  final dynamic deviceToken;

  Datum({
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
    required this.deviceToken,
  });

  Datum copyWith({
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
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    int? connections,
    dynamic profilPic,
    dynamic deviceToken,
  }) =>
      Datum(
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
        deviceToken: deviceToken ?? this.deviceToken,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    deviceToken: json["device_token"],
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
    "device_token": deviceToken,
  };
}
