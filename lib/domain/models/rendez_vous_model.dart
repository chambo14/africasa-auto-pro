import 'package:meta/meta.dart';
import 'dart:convert';

class RendezVousModel {
  final bool? success;
  final Data? data;
  final String? message;

  RendezVousModel({
     this.success,
     this.data,
     this.message,
  });

  RendezVousModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      RendezVousModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory RendezVousModel.fromRawJson(String str) => RendezVousModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RendezVousModel.fromJson(Map<String, dynamic> json) => RendezVousModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  final int clientId;
  final int mecanicienId;
  final DateTime dateRdv;
  final String hourStartRdv;
  final String hourEndRdv;
  final String updatedAt;
  final String createdAt;

  Data({
    required this.clientId,
    required this.mecanicienId,
    required this.dateRdv,
    required this.hourStartRdv,
    required this.hourEndRdv,
    required this.updatedAt,
    required this.createdAt,
  });

  Data copyWith({
    int? clientId,
    int? mecanicienId,
    DateTime? dateRdv,
    String? hourStartRdv,
    String? hourEndRdv,
    String? updatedAt,
    String? createdAt,
  }) =>
      Data(
        clientId: clientId ?? this.clientId,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        dateRdv: dateRdv ?? this.dateRdv,
        hourStartRdv: hourStartRdv ?? this.hourStartRdv,
        hourEndRdv: hourEndRdv ?? this.hourEndRdv,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clientId: json["client_id"],
    mecanicienId: json["mecanicien_id"],
    dateRdv: DateTime.parse(json["date_rdv"]),
    hourStartRdv: json["hour_start_rdv"],
    hourEndRdv: json["hour_end_rdv"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "mecanicien_id": mecanicienId,
    "date_rdv": "${dateRdv.year.toString().padLeft(4, '0')}-${dateRdv.month.toString().padLeft(2, '0')}-${dateRdv.day.toString().padLeft(2, '0')}",
    "hour_start_rdv": hourStartRdv,
    "hour_end_rdv": hourEndRdv,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}
