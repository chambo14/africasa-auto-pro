import 'package:africasa_mecano/domain/models/liste_catalogue_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../domain/models/appoint_model.dart';
import '../networkService/repository/api_repository.dart';

final listCatalogue = ChangeNotifierProvider((ref) => LisCatalogueProvider());

class LisCatalogueProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  ListCatalogueModel? _listCatalogueModel;

  bool _isLoading = false;

  Future<ListCatalogueModel?> listCatalogue({required int id}) async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.getListCatalogue(id);
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _listCatalogueModel = response;
  }

  ListCatalogueModel? get listCatalogueModel => _listCatalogueModel;

  bool get isLoading => _isLoading;
}