import 'package:africasa_mecano/domain/models/approve_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networkService/repository/api_repository.dart';

final approveProvider =
ChangeNotifierProvider((ref) => ApproveProvider());

class ApproveProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<ApproveModel?> approve(
      {required int id}) async {
    final response = await _apiRepository.validateAppointment(id);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}