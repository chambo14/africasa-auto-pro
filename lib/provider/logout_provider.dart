
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/logout_model.dart';
import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';


final logoutProvider =
ChangeNotifierProvider((ref) => LogoutUserProvider());

class LogoutUserProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  late ResponseModel _responseData;
  bool _isConnected = false;

  Future<LogoutModel?>  logoutUser() async {
    _isConnected = true;
    notifyListeners();
    final response = await _apiRepository.logoutCustomer();
    _isConnected = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }

  ResponseModel get responseData => _responseData;

  bool get isConnected => _isConnected;
}
