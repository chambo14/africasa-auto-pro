import 'package:meta/meta.dart';
import 'dart:convert';

class DayModel {
  final bool? success;
  final Data? data;
  final String? message;

  DayModel({
     this.success,
     this.data,
     this.message,
  });

  DayModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DayModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DayModel.fromRawJson(String str) => DayModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DayModel.fromJson(Map<String, dynamic> json) => DayModel(
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
  final int mecanicienId;
  final String libelle;
  final String horaire;

  Data({
    required this.mecanicienId,
    required this.libelle,
    required this.horaire,
  });

  Data copyWith({
    int? mecanicienId,
    String? libelle,
    String? horaire,
  }) =>
      Data(
        mecanicienId: mecanicienId ?? this.mecanicienId,
        libelle: libelle ?? this.libelle,
        horaire: horaire ?? this.horaire,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mecanicienId: json["mecanicien_id"],
    libelle: json["libelle"],
    horaire: json["horaire"],
  );

  Map<String, dynamic> toJson() => {
    "mecanicien_id": mecanicienId,
    "libelle": libelle,
    "horaire": horaire,
  };
}
