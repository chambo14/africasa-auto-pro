import 'package:meta/meta.dart';
import 'dart:convert';

class DayListModel {
  final bool? success;
  final List<Datum>? data;
  final String? message;

  DayListModel({
     this.success,
     this.data,
     this.message,
  });

  DayListModel copyWith({
    bool? success,
    List<Datum>? data,
    String? message,
  }) =>
      DayListModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DayListModel.fromRawJson(String str) => DayListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DayListModel.fromJson(Map<String, dynamic> json) => DayListModel(
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
  final int? mecanicienId;
  final String? libelle;
  final String? horaire;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.mecanicienId,
    required this.libelle,
    required this.horaire,
    required this.createdAt,
    required this.updatedAt,
  });

  Datum copyWith({
    int? id,
    int? mecanicienId,
    String? libelle,
    String? horaire,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        libelle: libelle ?? this.libelle,
        horaire: horaire ?? this.horaire,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
