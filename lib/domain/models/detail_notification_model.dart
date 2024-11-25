import 'package:meta/meta.dart';
import 'dart:convert';

class DetailNotificationModel {
  final bool? success;
  final Data? data;
  final String? message;

  DetailNotificationModel({
     this.success,
     this.data,
     this.message,
  });

  DetailNotificationModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DetailNotificationModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailNotificationModel.fromRawJson(String str) => DetailNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailNotificationModel.fromJson(Map<String, dynamic> json) => DetailNotificationModel(
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
  final int id;
  final int userId;
  final String title;
  final String message;
  final DateTime readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    int? id,
    int? userId,
    String? title,
    String? message,
    DateTime? readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        message: message ?? this.message,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    message: json["message"],
    readAt: DateTime.parse(json["read_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "message": message,
    "read_at": readAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
