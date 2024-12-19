
import 'package:africasa_mecano/domain/models/delete_compt_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../networkService/repository/api_repository.dart';

final deleteCompteProvider = ChangeNotifierProvider((ref) => DeleteProvider());

class DeleteProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  late DeleteComptModel _responseData;
  bool _isConnected = false;

  Future<DeleteComptModel?>  deleteUser() async {
    _isConnected = true;
    notifyListeners();
    final response = await _apiRepository.deleteAccount();
    _isConnected = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }

  DeleteComptModel get responseData => _responseData;

  bool get isConnected => _isConnected;
}