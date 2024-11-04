import 'package:meta/meta.dart';
import 'dart:convert';

class InfoMecanoModel {
  final bool? success;
  final Data? data;
  final String? message;

  InfoMecanoModel({
     this.success,
     this.data,
     this.message,
  });

  InfoMecanoModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      InfoMecanoModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory InfoMecanoModel.fromRawJson(String str) => InfoMecanoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoMecanoModel.fromJson(Map<String, dynamic> json) => InfoMecanoModel(
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
  final int id;
  final int userId;
  final String name;
  final String lastname;
  final String email;
  final String contact;
  final dynamic contact2;
  final String adresse;
  final dynamic ville;
  final dynamic numCni;
  final dynamic photo;
  final int societeId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String speciality;
  final int experience;
  final int totalNotes;
  final List<Note> notes;
  final Societe societe;
  final List<dynamic> contacts;

  Data({
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
    required this.totalNotes,
    required this.notes,
    required this.societe,
    required this.contacts,
  });

  Data copyWith({
    int? id,
    int? userId,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    dynamic contact2,
    String? adresse,
    dynamic ville,
    dynamic numCni,
    dynamic photo,
    int? societeId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    String? speciality,
    int? experience,
    int? totalNotes,
    List<Note>? notes,
    Societe? societe,
    List<dynamic>? contacts,
  }) =>
      Data(
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
        totalNotes: totalNotes ?? this.totalNotes,
        notes: notes ?? this.notes,
        societe: societe ?? this.societe,
        contacts: contacts ?? this.contacts,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    speciality: json["speciality"],
    experience: json["experience"],
    totalNotes: json["total_notes"],
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
    societe: Societe.fromJson(json["societe"]),
    contacts: List<dynamic>.from(json["contacts"].map((x) => x)),
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
    "total_notes": totalNotes,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    "societe": societe.toJson(),
    "contacts": List<dynamic>.from(contacts.map((x) => x)),
  };
}

class Note {
  final int id;
  final int mecanicienId;
  final int note;
  final String avis;
  final int isApprove;
  final String createdAt;
  final String updatedAt;

  Note({
    required this.id,
    required this.mecanicienId,
    required this.note,
    required this.avis,
    required this.isApprove,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    int? id,
    int? mecanicienId,
    int? note,
    String? avis,
    int? isApprove,
    String? createdAt,
    String? updatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        mecanicienId: mecanicienId ?? this.mecanicienId,
        note: note ?? this.note,
        avis: avis ?? this.avis,
        isApprove: isApprove ?? this.isApprove,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Note.fromRawJson(String str) => Note.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    mecanicienId: json["mecanicien_id"],
    note: json["note"],
    avis: json["avis"],
    isApprove: json["is_approve"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mecanicien_id": mecanicienId,
    "note": note,
    "avis": avis,
    "is_approve": isApprove,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
    String? nomGerant,
    String? contactGerant,
    dynamic phone,
    String? presentation,
    dynamic lieu,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
