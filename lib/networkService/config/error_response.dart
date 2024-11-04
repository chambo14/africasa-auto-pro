import 'package:dio/dio.dart';

class ErrorResponse {
  static checkMessage(Object e) {
    String res = "Une erreur technique s'est produite";
    if (e is DioError) {
        if (e.response?.data != null && e.response?.data is Map && (e.response?.data as Map).containsKey('message')) {
        res = (e.response?.data as Map)['message'];
      }
    }
    return res;
  }
}