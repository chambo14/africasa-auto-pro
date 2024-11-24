import 'package:meta/meta.dart';
import 'dart:convert';

class ListCatalogueModel {
  final bool? success;
  final List<Datum>? data;
  final String? message;

  ListCatalogueModel({
     this.success,
     this.data,
     this.message,
  });

  ListCatalogueModel copyWith({
    bool? success,
    List<Datum>? data,
    String? message,
  }) =>
      ListCatalogueModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory ListCatalogueModel.fromRawJson(String str) => ListCatalogueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListCatalogueModel.fromJson(Map<String, dynamic> json) => ListCatalogueModel(
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
  final int id;
  final int mecanicienId;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.mecanicienId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  Datum copyWith({
    int? id,
    int? mecanicienId,
    String? photo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        photo: photo ?? this.photo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
