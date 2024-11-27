import 'package:africasa_mecano/domain/models/delete_catalogue_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networkService/repository/api_repository.dart';

final deleteCatalogueProvider =
ChangeNotifierProvider((ref) => DeleteCatalogueProvider());

class DeleteCatalogueProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<DeleteCatalogueModel?> delete(
      {required int id}) async {
    final response = await _apiRepository.deletedCatalogue(id);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}