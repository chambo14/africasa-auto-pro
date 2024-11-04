import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../networkService/repository/api_repository.dart';

final listOperationProvider = ChangeNotifierProvider((ref) => ListOperationProvider());

class ListOperationProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  ListOperationModel? _listOperationModel;

  bool _isLoading = false;

  Future<ListOperationModel?> getListOperation() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.listOperations();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _listOperationModel = response;
  }

  ListOperationModel? get listOperationModel => _listOperationModel;

  bool get isLoading => _isLoading;
}