import 'dart:convert';

class ApproveModel {
  final bool? success;
  final Data? data;
  final String? message;

  ApproveModel({
    this.success,
    this.data,
    this.message,
  });

  ApproveModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      ApproveModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory ApproveModel.fromRawJson(String str) =>
      ApproveModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApproveModel.fromJson(Map<String, dynamic> json) => ApproveModel(
    success: json["success"] ?? false, // Valeur par défaut
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"] ?? "", // Gestion du null pour le message
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final int id;
  final int clientId;
  final int mecanicienId;
  final DateTime dateRdv;
  final String hourStartRdv;
  final String hourEndRdv;
  final String status;
  final bool isActive;
  dynamic deletedAt;
  final String? createdAt; // Nullabilité ajoutée
  final String? updatedAt; // Nullabilité ajoutée

  Data({
    required this.id,
    required this.clientId,
    required this.mecanicienId,
    required this.dateRdv,
    required this.hourStartRdv,
    required this.hourEndRdv,
    required this.status,
    required this.isActive,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Data copyWith({
    int? id,
    int? clientId,
    int? mecanicienId,
    DateTime? dateRdv,
    String? hourStartRdv,
    String? hourEndRdv,
    String? status,
    bool? isActive,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
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
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? 0, // Fournir une valeur par défaut
    clientId: json["client_id"] ?? 0,
    mecanicienId: json["mecanicien_id"] ?? 0,
    dateRdv: json["date_rdv"] != null
        ? DateTime.parse(json["date_rdv"])
        : DateTime.now(), // Valeur par défaut si null
    hourStartRdv: json["hour_start_rdv"] ?? "", // Valeur par défaut
    hourEndRdv: json["hour_end_rdv"] ?? "", // Valeur par défaut
    status: json["status"] ?? "", // Valeur par défaut
    isActive: json["is_active"] ?? false,
    deletedAt: json["deleted_at"], // Peut être null
    createdAt: json["created_at"], // Nullable
    updatedAt: json["updated_at"], // Nullable
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
  };
}
