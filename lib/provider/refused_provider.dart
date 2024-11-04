import 'package:africasa_mecano/domain/models/approve_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networkService/repository/api_repository.dart';

final refusedProvider =
ChangeNotifierProvider((ref) => RefusedProvider());

class RefusedProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<ApproveModel?> refused(
      {required int id}) async {
    final response = await _apiRepository.RefusedAppointment(id);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}