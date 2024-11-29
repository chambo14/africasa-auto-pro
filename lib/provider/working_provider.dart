import 'package:africasa_mecano/domain/models/day_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final workingProvider =
ChangeNotifierProvider((ref) => WorkingProvider());

class WorkingProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<DayModel?> working(
      {required int mecanicienId, required String libelle, required String horaire}) async {
    final response = await _apiRepository.working(mecanicienId, libelle, horaire);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}