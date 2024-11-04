import 'package:africasa_mecano/domain/models/password_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final forgotProvider =
ChangeNotifierProvider((ref) => PasswordForgotProvider());

class PasswordForgotProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<PasswordModel?> forgot(
      {required String contact}) async {
    final response = await _apiRepository.passwordForgot(contact);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}