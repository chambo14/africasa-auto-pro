import 'package:meta/meta.dart';
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
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  final List<AllOperation> allOperations;
  final List<AllOperation> entrees;
  final List<AllOperation> sorties;

  Data({
    required this.allOperations,
    required this.entrees,
    required this.sorties,
  });

  Data copyWith({
    List<AllOperation>? allOperations,
    List<AllOperation>? entrees,
    List<AllOperation>? sorties,
  }) =>
      Data(
        allOperations: allOperations ?? this.allOperations,
        entrees: entrees ?? this.entrees,
        sorties: sorties ?? this.sorties,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    allOperations: List<AllOperation>.from(json["all_operations"].map((x) => AllOperation.fromJson(x))),
    entrees: List<AllOperation>.from(json["entrees"].map((x) => AllOperation.fromJson(x))),
    sorties: List<AllOperation>.from(json["sorties"].map((x) => AllOperation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "all_operations": List<dynamic>.from(allOperations.map((x) => x.toJson())),
    "entrees": List<dynamic>.from(entrees.map((x) => x.toJson())),
    "sorties": List<dynamic>.from(sorties.map((x) => x.toJson())),
  };
}

class AllOperation {
  final int id;
  final String reference;
  final DateTime dateOperation;
  final String libelle;
  final String motif;
  final int amount;
  final TypeOperation typeOperation;
  final dynamic fichier;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;

  AllOperation({
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

  AllOperation copyWith({
    int? id,
    String? reference,
    DateTime? dateOperation,
    String? libelle,
    String? motif,
    int? amount,
    TypeOperation? typeOperation,
    dynamic fichier,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
  }) =>
      AllOperation(
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

  factory AllOperation.fromRawJson(String str) => AllOperation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllOperation.fromJson(Map<String, dynamic> json) => AllOperation(
    id: json["id"],
    reference: json["reference"],
    dateOperation: DateTime.parse(json["date_operation"]),
    libelle: json["libelle"],
    motif: json["motif"],
    amount: json["amount"],
    typeOperation: typeOperationValues.map[json["type_operation"]]!,
    fichier: json["fichier"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "date_operation": "${dateOperation.year.toString().padLeft(4, '0')}-${dateOperation.month.toString().padLeft(2, '0')}-${dateOperation.day.toString().padLeft(2, '0')}",
    "libelle": libelle,
    "motif": motif,
    "amount": amount,
    "type_operation": typeOperationValues.reverse[typeOperation],
    "fichier": fichier,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_id": userId,
  };
}

enum TypeOperation {
  ENTREE,
  SORTIE
}

final typeOperationValues = EnumValues({
  "ENTREE": TypeOperation.ENTREE,
  "SORTIE": TypeOperation.SORTIE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
