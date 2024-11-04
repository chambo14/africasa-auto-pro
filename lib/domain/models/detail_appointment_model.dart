import 'package:meta/meta.dart';
import 'dart:convert';

class DetailAppointmentModel {
  final bool? success;
  final Data? data;
  final String? message;

  DetailAppointmentModel({
     this.success,
     this.data,
     this.message,
  });

  DetailAppointmentModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DetailAppointmentModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailAppointmentModel.fromRawJson(String str) => DetailAppointmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailAppointmentModel.fromJson(Map<String, dynamic> json) => DetailAppointmentModel(
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
  final Appointment appointment;

  Data({
    required this.appointment,
  });

  Data copyWith({
    Appointment? appointment,
  }) =>
      Data(
        appointment: appointment ?? this.appointment,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    appointment: Appointment.fromJson(json["appointment"]),
  );

  Map<String, dynamic> toJson() => {
    "appointment": appointment.toJson(),
  };
}

class Appointment {
  final int id;
  final int clientId;
  final int mecanicienId;
  final DateTime dateRdv;
  final String hourStartRdv;
  final String hourEndRdv;
  final dynamic status;
  final dynamic isActive;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  final Client client;

  Appointment({
    required this.id,
    required this.clientId,
    required this.mecanicienId,
    required this.dateRdv,
    required this.hourStartRdv,
    required this.hourEndRdv,
    required this.status,
    required this.isActive,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.client,
  });

  Appointment copyWith({
    int? id,
    int? clientId,
    int? mecanicienId,
    DateTime? dateRdv,
    String? hourStartRdv,
    String? hourEndRdv,
    dynamic status,
    dynamic isActive,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
    Client? client,
  }) =>
      Appointment(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        dateRdv: dateRdv ?? this.dateRdv,
        hourStartRdv: hourStartRdv ?? this.hourStartRdv,
        hourEndRdv: hourEndRdv ?? this.hourEndRdv,
        status: status ?? this.status,
        isActive: isActive ?? this.isActive,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        client: client ?? this.client,
      );

  factory Appointment.fromRawJson(String str) => Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json["id"],
    clientId: json["client_id"],
    mecanicienId: json["mecanicien_id"],
    dateRdv: DateTime.parse(json["date_rdv"]),
    hourStartRdv: json["hour_start_rdv"],
    hourEndRdv: json["hour_end_rdv"],
    status: json["status"],
    isActive: json["is_active"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    client: Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "mecanicien_id": mecanicienId,
    "date_rdv": "${dateRdv.year.toString().padLeft(4, '0')}-${dateRdv.month.toString().padLeft(2, '0')}-${dateRdv.day.toString().padLeft(2, '0')}",
    "hour_start_rdv": hourStartRdv,
    "hour_end_rdv": hourEndRdv,
    "status": status,
    "is_active": isActive,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "client": client.toJson(),
  };
}

class Client {
  final int id;
  final int userId;
  final String name;
  final String lastname;
  final String email;
  final String contact;
  final dynamic contact2;
  final dynamic adresse;
  final dynamic ville;
  final dynamic numCni;
  final dynamic numPermis;
  final dynamic photo;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  Client({
    required this.id,
    required this.userId,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    required this.contact2,
    required this.adresse,
    required this.ville,
    required this.numCni,
    required this.numPermis,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  Client copyWith({
    int? id,
    int? userId,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    dynamic contact2,
    dynamic adresse,
    dynamic ville,
    dynamic numCni,
    dynamic numPermis,
    dynamic photo,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      Client(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        contact2: contact2 ?? this.contact2,
        adresse: adresse ?? this.adresse,
        ville: ville ?? this.ville,
        numCni: numCni ?? this.numCni,
        numPermis: numPermis ?? this.numPermis,
        photo: photo ?? this.photo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    contact: json["contact"],
    contact2: json["contact_2"],
    adresse: json["adresse"],
    ville: json["ville"],
    numCni: json["num_cni"],
    numPermis: json["num_permis"],
    photo: json["photo"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "lastname": lastname,
    "email": email,
    "contact": contact,
    "contact_2": contact2,
    "adresse": adresse,
    "ville": ville,
    "num_cni": numCni,
    "num_permis": numPermis,
    "photo": photo,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
