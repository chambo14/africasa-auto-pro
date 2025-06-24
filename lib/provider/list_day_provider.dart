import 'package:africasa_mecano/domain/models/day_list_model.dart';
import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../networkService/repository/api_repository.dart';

final listDayProvider = ChangeNotifierProvider((ref) => ListDayProvider());

class ListDayProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  DayListModel? _dayListModel;

  bool _isLoading = false;

  Future<DayListModel?> getListDay() async {
    _isLoading = true;
    // notifyListeners();
    var response = await _apiRepository.getListDay();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _dayListModel = response;

    return _dayListModel;
  }

  DayListModel? get dayListModel => _dayListModel;

  bool get isLoading => _isLoading;
}