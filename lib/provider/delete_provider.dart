
import 'package:africasa_mecano/domain/models/delete_compt_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/user_info_model.dart';
import '../networkService/repository/api_repository.dart';

final deleteCompteProvider = ChangeNotifierProvider((ref) => DeleteProvider());

class DeleteProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  DeleteComptModel? _deleteComptModel;

  bool _isLoading = false;

  Future<DeleteComptModel?> supprimerCompte() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.deleteAccount();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _deleteComptModel = response;
  }

  DeleteComptModel? get deleteComptModel => _deleteComptModel;

  bool get isLoading => _isLoading;
}