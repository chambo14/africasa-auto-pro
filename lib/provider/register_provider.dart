import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final registerControllerProvider =
    ChangeNotifierProvider((ref) => RegisterPhoneController());

class RegisterPhoneController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<ResponseModel?> register(
      {required String type_user,required String name, required String lastname, required  String email, required String contact, required String password}) async {
    final response = await _apiRepository.registerCustomer(type_user, name, lastname, email, contact, password);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}