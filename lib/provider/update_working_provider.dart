import 'package:africasa_mecano/domain/models/day_model.dart';
import 'package:africasa_mecano/domain/models/update_day_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final updateWorkingProvider =
ChangeNotifierProvider((ref) => UpdateWorkingProvider());

class UpdateWorkingProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<UpdateDayModel?> working(
      {required int mecanicienId, required String libelle, required String horaire, required int id}) async {
    final response = await _apiRepository.updateWorking(mecanicienId, libelle, horaire, id);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}