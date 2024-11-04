import 'package:africasa_mecano/domain/models/password_model.dart';
import 'package:africasa_mecano/domain/models/reset_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final resetProvider =
ChangeNotifierProvider((ref) => ResetProvider());

class ResetProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<ResetModel?> forgot(
      {required String contact, token, password, confirm_password}) async {
    final response = await _apiRepository.resetForgot(contact, token, password, confirm_password);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}