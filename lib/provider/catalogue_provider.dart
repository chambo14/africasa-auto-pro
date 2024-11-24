import 'dart:io';

import 'package:africasa_mecano/domain/models/catalogue_modele.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../networkService/repository/api_repository.dart';

final catalogueProvider =
ChangeNotifierProvider((ref) => CatalogueProvider());

class CatalogueProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<CatalogueModel?> updloadCatalogue(
      {required int mecanicienId,required File fichier}) async {
    final response = await _apiRepository.rechargedCatalogue(mecanicienId,fichier);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}