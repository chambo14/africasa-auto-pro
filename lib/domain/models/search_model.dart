import 'package:meta/meta.dart';
import 'dart:convert';

class SearchModel {
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
  final String photo;
  final int societeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String speciality;
  final int experience;

  SearchModel({
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
  });

  SearchModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? lastname,
    String? email,
    String? contact,
    dynamic contact2,
    String? adresse,
    String? ville,
    String? numCni,
    String? photo,
    int? societeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic deletedAt,
    String? speciality,
    int? experience,
  }) =>
      SearchModel(
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
      );

  factory SearchModel.fromRawJson(String str) => SearchModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "speciality": speciality,
    "experience": experience,
  };
}
