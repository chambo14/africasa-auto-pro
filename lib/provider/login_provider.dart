import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final loginControllerProvider =
ChangeNotifierProvider((ref) => LoginPhoneController());

class LoginPhoneController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<ResponseModel?> login(
      {required String login, required String password}) async {
    final response = await _apiRepository.loginCustomer(login, password);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}