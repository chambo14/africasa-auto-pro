
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/mecano_model.dart';
import '../networkService/repository/api_repository.dart';




final mecanoControllerProvider = ChangeNotifierProvider((ref) => ListeMecaController());

class ListeMecaController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  MecamoModel? _mecanoModel;

  bool _isLoading = false;

  Future<MecamoModel?> getListMecaniciens() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.getListMecano();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _mecanoModel = response;
  }

  MecamoModel? get mecamoModel => _mecanoModel;

  bool get isLoading => _isLoading;
}