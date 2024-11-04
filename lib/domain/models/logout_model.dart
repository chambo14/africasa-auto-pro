import 'package:meta/meta.dart';
import 'dart:convert';

class LogoutModel {
  final bool? success;
  final List<dynamic>? data;
  final String? message;

  LogoutModel({
     this.success,
     this.data,
     this.message,
  });

  LogoutModel copyWith({
    bool? success,
    List<dynamic>? data,
    String? message,
  }) =>
      LogoutModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory LogoutModel.fromRawJson(String str) => LogoutModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
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
