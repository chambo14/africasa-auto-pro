import 'package:meta/meta.dart';
import 'dart:convert';

class DeleteComptModel {
  final bool? success;
  final List<dynamic>? data;
  final String? message;

  DeleteComptModel({
     this.success,
     this.data,
     this.message,
  });

  DeleteComptModel copyWith({
    bool? success,
    List<dynamic>? data,
    String? message,
  }) =>
      DeleteComptModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DeleteComptModel.fromRawJson(String str) => DeleteComptModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteComptModel.fromJson(Map<String, dynamic> json) => DeleteComptModel(
    success: json["success"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
