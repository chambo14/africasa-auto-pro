import 'package:meta/meta.dart';
import 'dart:convert';

class UpdateDayModel {
  final bool? success;
  final Data? data;
  final String? message;

  UpdateDayModel({
     this.success,
     this.data,
     this.message,
  });

  UpdateDayModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      UpdateDayModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory UpdateDayModel.fromRawJson(String str) => UpdateDayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateDayModel.fromJson(Map<String, dynamic> json) => UpdateDayModel(
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
  final int id;
  final int mecanicienId;
  final String libelle;
  final String horaire;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.mecanicienId,
    required this.libelle,
    required this.horaire,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    int? mecanicienId,
    String? libelle,
    String? horaire,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        libelle: libelle ?? this.libelle,
        horaire: horaire ?? this.horaire,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mecanicienId: json["mecanicien_id"],
    libelle: json["libelle"],
    horaire: json["horaire"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mecanicien_id": mecanicienId,
    "libelle": libelle,
    "horaire": horaire,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
