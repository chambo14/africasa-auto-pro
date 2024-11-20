import 'dart:developer';

import 'package:africasa_mecano/domain/models/update_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final updateProfileProvider =
ChangeNotifierProvider((ref) => UpdateProfilProvider());

class UpdateProfilProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<UpdateProfilModel?> updateProfile(
      {required String name, required String lastname, required String ville, required String adresse, required String num_cni}) async {
    final response = await _apiRepository.UpdateProfil(name, lastname, ville, adresse, num_cni);
    notifyListeners();
    if (response == null) {
      return null;
    }

    log(response.success.toString());

    return response;
  }
}