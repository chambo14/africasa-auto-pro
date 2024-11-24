import 'package:meta/meta.dart';
import 'dart:convert';

class CatalogueModel {
  final bool? success;
  final Data? data;
  final String? message;

  CatalogueModel({
     this.success,
     this.data,
     this.message,
  });

  CatalogueModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      CatalogueModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory CatalogueModel.fromRawJson(String str) => CatalogueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatalogueModel.fromJson(Map<String, dynamic> json) => CatalogueModel(
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
  final String mecanicienId;
  final String photo;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.mecanicienId,
    required this.photo,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  Data copyWith({
    String? mecanicienId,
    String? photo,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Data(
        mecanicienId: mecanicienId ?? this.mecanicienId,
        photo: photo ?? this.photo,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mecanicienId: json["mecanicien_id"],
    photo: json["photo"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "mecanicien_id": mecanicienId,
    "photo": photo,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
