import 'package:africasa_mecano/domain/models/operation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/response_model.dart';
import '../networkService/repository/api_repository.dart';

final operationProvider =
ChangeNotifierProvider((ref) => OperationController());

class OperationController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<OperationModel?> operation(
      {required String date_operation, required String libelle, required String motif,required String amount, required String type_operation}) async {
    final response = await _apiRepository.doOperation(date_operation, libelle, motif,amount, type_operation );
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}