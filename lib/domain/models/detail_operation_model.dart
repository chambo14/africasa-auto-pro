import 'package:meta/meta.dart';
import 'dart:convert';

class DetailOperationModel {
  final bool? success;
  final Data? data;
  final String? message;

  DetailOperationModel({
     this.success,
     this.data,
     this.message,
  });

  DetailOperationModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DetailOperationModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailOperationModel.fromRawJson(String str) => DetailOperationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailOperationModel.fromJson(Map<String, dynamic> json) => DetailOperationModel(
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
  final Operation operation;

  Data({
    required this.operation,
  });

  Data copyWith({
    Operation? operation,
  }) =>
      Data(
        operation: operation ?? this.operation,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    operation: Operation.fromJson(json["operation"]),
  );

  Map<String, dynamic> toJson() => {
    "operation": operation.toJson(),
  };
}

class Operation {
  final int id;
  final String reference;
  final DateTime dateOperation;
  final String libelle;
  final String motif;
  final int amount;
  final String typeOperation;
  final dynamic fichier;
  final String createdAt;
  final String updatedAt;
  final int userId;

  Operation({
    required this.id,
    required this.reference,
    required this.dateOperation,
    required this.libelle,
    required this.motif,
    required this.amount,
    required this.typeOperation,
    required this.fichier,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  Operation copyWith({
    int? id,
    String? reference,
    DateTime? dateOperation,
    String? libelle,
    String? motif,
    int? amount,
    String? typeOperation,
    dynamic fichier,
    String? createdAt,
    String? updatedAt,
    int? userId,
  }) =>
      Operation(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        dateOperation: dateOperation ?? this.dateOperation,
        libelle: libelle ?? this.libelle,
        motif: motif ?? this.motif,
        amount: amount ?? this.amount,
        typeOperation: typeOperation ?? this.typeOperation,
        fichier: fichier ?? this.fichier,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );

  factory Operation.fromRawJson(String str) => Operation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
    id: json["id"],
    reference: json["reference"],
    dateOperation: DateTime.parse(json["date_operation"]),
    libelle: json["libelle"],
    motif: json["motif"],
    amount: json["amount"],
    typeOperation: json["type_operation"],
    fichier: json["fichier"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "date_operation": "${dateOperation.year.toString().padLeft(4, '0')}-${dateOperation.month.toString().padLeft(2, '0')}-${dateOperation.day.toString().padLeft(2, '0')}",
    "libelle": libelle,
    "motif": motif,
    "amount": amount,
    "type_operation": typeOperation,
    "fichier": fichier,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user_id": userId,
  };
}
