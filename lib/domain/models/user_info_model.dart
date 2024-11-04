import 'package:meta/meta.dart';
import 'dart:convert';

class UserInfoModel {
  final bool? success;
  final Data? data;
  final String? message;

  UserInfoModel({
    this.success,
    this.data,
    this.message,
  });

  UserInfoModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      UserInfoModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory UserInfoModel.fromRawJson(String str) => UserInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    success: json["success"] as bool?,
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int id;
  final String reference;
  final String typeUser;
  final String name;
  final String lastname;
  final String email;
  final String contact;
  final dynamic emailVerifiedAt;
  final int isActive;
  final int isBanned;
  final int isValidated;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final int connections;
  final String profilPic;
  final Mecanicien? mecanicien;

  Data({
    required this.id,
    required this.reference,
    required this.typeUser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    this.emailVerifiedAt,
    required this.isActive,
    required this.isBanned,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.connections,
    required this.profilPic,
    this.mecanicien,
  });

  Data copyWith({
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
    String? profilPic,
    Mecanicien? mecanicien,
  }) =>
      Data(
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
        mecanicien: mecanicien ?? this.mecanicien,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0,
    reference: json["reference"] ?? '',
    typeUser: json["type_user"] ?? '',
    name: json["name"] ?? '',
    lastname: json["lastname"] ?? '',
    email: json["email"] ?? '',
    contact: json["contact"] ?? '',
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"] ?? 0,
    isBanned: json["is_banned"] ?? 0,
    isValidated: json["is_validated"] ?? 0,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    deletedAt: json["deleted_at"],
    connections: json["connections"] ?? 0,
    profilPic: json["profil_pic"] ?? '',
    mecanicien: json["mecanicien"] != null ? Mecanicien.fromJson(json["mecanicien"]) : null,
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
    "mecanicien": mecanicien?.toJson(),
  };
}

class Mecanicien {
  final int id;
  final int userId;
  final String name;
  final String lastname;
  final String email;
  final String contact;
  final dynamic contact2;
  final String adresse;
  final String ville;
  final String numCni;
  final dynamic photo;
  final int societeId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String speciality;
  final int experience;
  final Societe societe;
  final List<dynamic> contacts;

  Mecanicien({
    required this.id,
    required this.userId,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    this.contact2,
    required this.adresse,
    required this.ville,
    required this.numCni,
    this.photo,
    required this.societeId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.speciality,
    required this.experience,
    required this.societe,
    required this.contacts,
  });

  factory Mecanicien.fromJson(Map<String, dynamic> json) => Mecanicien(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    name: json["name"] ?? '',
    lastname: json["lastname"] ?? '',
    email: json["email"] ?? '',
    contact: json["contact"] ?? '',
    contact2: json["contact_2"],
    adresse: json["adresse"] ?? '',
    ville: json["ville"] ?? '',
    numCni: json["num_cni"] ?? '',
    photo: json["photo"],
    societeId: json["societe_id"] ?? 0,
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
    deletedAt: json["deleted_at"],
    speciality: json["speciality"] ?? '',
    experience: json["experience"] ?? 0,
    societe: json["societe"] != null ? Societe.fromJson(json["societe"]) : Societe.empty(),
    contacts: json["contacts"] != null ? List<dynamic>.from(json["contacts"].map((x) => x)) : [],
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
    "photo": photo,
    "societe_id": societeId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "speciality": speciality,
    "experience": experience,
    "societe": societe.toJson(),
    "contacts": contacts,
  };
}

class Societe {
  final int id;
  final String reference;
  final String libelle;
  final String adresse;
  final String nomGerant;
  final String contactGerant;
  final dynamic phone;
  final String presentation;
  final dynamic lieu;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;

  Societe({
    required this.id,
    required this.reference,
    required this.libelle,
    required this.adresse,
    required this.nomGerant,
    required this.contactGerant,
    this.phone,
    required this.presentation,
    this.lieu,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Societe.empty() {
    return Societe(
      id: 0,
      reference: '',
      libelle: '',
      adresse: '',
      nomGerant: '',
      contactGerant: '',
      phone: null,
      presentation: '',
      lieu: null,
      deletedAt: null,
      createdAt: '',
      updatedAt: '',
    );
  }

  factory Societe.fromJson(Map<String, dynamic> json) => Societe(
    id: json["id"] ?? 0,
    reference: json["reference"] ?? '',
    libelle: json["libelle"] ?? '',
    adresse: json["adresse"] ?? '',
    nomGerant: json["nom_gerant"] ?? '',
    contactGerant: json["contact_gerant"] ?? '',
    phone: json["phone"],
    presentation: json["presentation"] ?? '',
    lieu: json["lieu"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] ?? '',
    updatedAt: json["updated_at"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "libelle": libelle,
    "adresse": adresse,
    "nom_gerant": nomGerant,
    "contact_gerant": contactGerant,
    "phone": phone,
    "presentation": presentation,
    "lieu": lieu,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
