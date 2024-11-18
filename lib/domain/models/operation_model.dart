import 'dart:convert';

class OperationModel {
  final bool? success;
  final Data? data;
  final String? message;

  OperationModel({
    this.success,
    this.data,
    this.message,
  });

  OperationModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      OperationModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory OperationModel.fromRawJson(String str) => OperationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
    success: json["success"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data != null ? data!.toJson() : null,
    "message": message,
  };
}

class Data {
  final DateTime dateOperation;
  final String? libelle;  // Champ nullable
  final String motif;
  final String amount;
  final String typeOperation;
  final String reference;
  final int userId;
  final String updatedAt;
  final String createdAt;
  final int id;

  Data({
    required this.dateOperation,
    this.libelle,  // Le champ nullable dans le constructeur
    required this.motif,
    required this.amount,
    required this.typeOperation,
    required this.reference,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  Data copyWith({
    DateTime? dateOperation,
    String? libelle,
    String? motif,
    String? amount,
    String? typeOperation,
    String? reference,
    int? userId,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) =>
      Data(
        dateOperation: dateOperation ?? this.dateOperation,
        libelle: libelle ?? this.libelle,
        motif: motif ?? this.motif,
        amount: amount ?? this.amount,
        typeOperation: typeOperation ?? this.typeOperation,
        reference: reference ?? this.reference,
        userId: userId ?? this.userId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dateOperation: DateTime.parse(json["date_operation"]),
    libelle: json["libelle"],  // Accepte les valeurs nulles
    motif: json["motif"],
    amount: json["amount"],
    typeOperation: json["type_operation"],
    reference: json["reference"],
    userId: json["user_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "date_operation": "${dateOperation.year.toString().padLeft(4, '0')}-${dateOperation.month.toString().padLeft(2, '0')}-${dateOperation.day.toString().padLeft(2, '0')}",
    "libelle": libelle,  // Gère correctement la valeur nulle
    "motif": motif,
    "amount": amount,
    "type_operation": typeOperation,
    "reference": reference,
    "user_id": userId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}

