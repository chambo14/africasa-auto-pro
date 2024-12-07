import 'package:meta/meta.dart';
import 'dart:convert';

class UpdateProfilModel {
  final bool? success;
  final Data? data;
  final String? message;

  UpdateProfilModel({
     this.success,
     this.data,
     this.message,
  });

  UpdateProfilModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      UpdateProfilModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory UpdateProfilModel.fromRawJson(String str) => UpdateProfilModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfilModel.fromJson(Map<String, dynamic> json) => UpdateProfilModel(
    success: json["success"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int? id;
  final String? reference;
  final String? typeUser;
  final String? name;
  final String? lastname;
  final String? email;
  final String? contact;
  final dynamic? emailVerifiedAt;
  final int? isActive;
  final int? isBanned;
  final int? isValidated;
  final String? createdAt;
  final String? updatedAt;
  final dynamic? deletedAt;
  final int? connections;
  final String? profilPic;
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
  final int? id;
  final int? userId;
  final String? name;
  final String? lastname;
  final String? email;
  final String? contact;
  final dynamic? contact2;
  final String? adresse;
  final String? ville;
  final String? numCni;
  final dynamic? photo;
  final int? societeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? speciality;
  final int? experience;
  final Societe societe;
  final List<Contact> contacts;

  Mecanicien({
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
    required this.photo,
    required this.societeId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.speciality,
    required this.experience,
    required this.societe,
    required this.contacts,
  });

  Mecanicien copyWith({
    int? id,
    int? userId,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    dynamic? contact2,
    String? adresse,
    String? ville,
    String? numCni,
    dynamic? photo,
    int? societeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic? deletedAt,
    String? speciality,
    int? experience,
    Societe? societe,
    List<Contact>? contacts,
  }) =>
      Mecanicien(
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
        photo: photo ?? this.photo,
        societeId: societeId ?? this.societeId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        speciality: speciality ?? this.speciality,
        experience: experience ?? this.experience,
        societe: societe ?? this.societe,
        contacts: contacts ?? this.contacts,
      );

  factory Mecanicien.fromRawJson(String str) => Mecanicien.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Mecanicien.fromJson(Map<String, dynamic> json) => Mecanicien(
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
    photo: json["photo"],
    societeId: json["societe_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    speciality: json["speciality"],
    experience: json["experience"],
    societe: Societe.fromJson(json["societe"]),
    contacts: List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "speciality": speciality,
    "experience": experience,
    "societe": societe.toJson(),
    "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
  };
}

class Contact {
  final int? id;
  final int? mecanicienId;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Contact({
    required this.id,
    required this.mecanicienId,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  Contact copyWith({
    int? id,
    int? mecanicienId,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Contact(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    mecanicienId: json["mecanicien_id"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mecanicien_id": mecanicienId,
    "phone": phone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Societe {
  final int? id;
  final String? reference;
  final String? libelle;
  final String? adresse;
  final dynamic? nomGerant;
  final dynamic? contactGerant;
  final dynamic? phone;
  final String? presentation;
  final String? lieu;
  final dynamic? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Societe({
    required this.id,
    required this.reference,
    required this.libelle,
    required this.adresse,
    required this.nomGerant,
    required this.contactGerant,
    required this.phone,
    required this.presentation,
    required this.lieu,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Societe copyWith({
    int? id,
    String? reference,
    String? libelle,
    String? adresse,
    dynamic nomGerant,
    dynamic contactGerant,
    dynamic phone,
    String? presentation,
    String? lieu,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Societe(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        libelle: libelle ?? this.libelle,
        adresse: adresse ?? this.adresse,
        nomGerant: nomGerant ?? this.nomGerant,
        contactGerant: contactGerant ?? this.contactGerant,
        phone: phone ?? this.phone,
        presentation: presentation ?? this.presentation,
        lieu: lieu ?? this.lieu,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Societe.fromRawJson(String str) => Societe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Societe.fromJson(Map<String, dynamic> json) => Societe(
    id: json["id"],
    reference: json["reference"],
    libelle: json["libelle"],
    adresse: json["adresse"],
    nomGerant: json["nom_gerant"],
    contactGerant: json["contact_gerant"],
    phone: json["phone"],
    presentation: json["presentation"],
    lieu: json["lieu"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
