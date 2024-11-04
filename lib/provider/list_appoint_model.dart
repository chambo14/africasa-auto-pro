
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/appoint_model.dart';
import '../networkService/repository/api_repository.dart';




final appointsProvider = ChangeNotifierProvider((ref) => ListAppointProvider());

class ListAppointProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  AppointModel? _appointModel;

  bool _isLoading = false;

  Future<AppointModel?> getListAppointment() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.listAppoints();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _appointModel = response;
  }

  AppointModel? get appointMOdel => _appointModel;

  bool get isLoading => _isLoading;
}