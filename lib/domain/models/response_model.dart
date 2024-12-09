import 'dart:convert';

class ResponseModel {
  final bool? success;
  final Data? data;
  final String? message;

  ResponseModel({
     this.success,
     this.data,
     this.message,
  });

  ResponseModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      ResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory ResponseModel.fromRawJson(String str) => ResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  final String? token;
  final User? user;

  Data({
     this.token,
     this.user,
  });

  Data copyWith({
    String? token,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final int? id;
  final String? reference;
  final String? typeUser;
  final String? name;
  final String? lastname;
  final String? email;
  final String? contact;
  final dynamic emailVerifiedAt;
  final int? isActive;
  final int? isBanned;
  final int? isValidated;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final Mecanicien mecanicien;

  User({
    required this.id,
    required this.reference,
    required this.typeUser,
    required this.name,
    required this.lastname,
    required this.email,
    required this.contact,
    required this.emailVerifiedAt,
    required this.isActive,
    required this.isBanned,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.mecanicien,
  });

  User copyWith({
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
    Mecanicien? mecanicien,
  }) =>
      User(
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
        mecanicien: mecanicien ?? this.mecanicien,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    reference: json["reference"],
    typeUser: json["type_user"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    contact: json["contact"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    isBanned: json["is_banned"],
    isValidated: json["is_validated"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    mecanicien: Mecanicien.fromJson(json["mecanicien"]),
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
    "mecanicien": mecanicien.toJson(),
  };
}

class Mecanicien {
  final int? id;
  final int? userId;
  final String? name;
  final String? lastname;
  final String? email;
  final String? contact;
  final dynamic contact2;
  final dynamic adresse;
  final dynamic ville;
  final dynamic numCni;
  final dynamic photo;
  final dynamic societeId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final dynamic speciality;
  final dynamic experience;

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
  });

  Mecanicien copyWith({
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
    dynamic photo,
    dynamic societeId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    dynamic speciality,
    dynamic experience,
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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "speciality": speciality,
    "experience": experience,
  };
}
