import 'package:africasa_mecano/domain/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final passwordProvider =
ChangeNotifierProvider((ref) => PasswordProvider());

class PasswordProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<UserModel?> changeP(
      {required String password, required String new_password, required confirm_password}) async {
    final response = await _apiRepository.changePassword(password, new_password, confirm_password);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}