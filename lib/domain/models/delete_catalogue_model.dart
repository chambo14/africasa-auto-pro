import 'package:meta/meta.dart';
import 'dart:convert';

class DeleteCatalogueModel {
  final bool? success;
  final Data? data;
  final String? message;

  DeleteCatalogueModel({
     this.success,
     this.data,
     this.message,
  });

  DeleteCatalogueModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DeleteCatalogueModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DeleteCatalogueModel.fromRawJson(String str) => DeleteCatalogueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteCatalogueModel.fromJson(Map<String, dynamic> json) => DeleteCatalogueModel(
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
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.mecanicienId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    int? mecanicienId,
    String? photo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        photo: photo ?? this.photo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    mecanicienId: json["mecanicien_id"],
    photo: json["photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mecanicien_id": mecanicienId,
    "photo": photo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
