
import 'package:africasa_mecano/domain/models/detail_operation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networkService/repository/api_repository.dart';


final detailOperationProvider = ChangeNotifierProvider((ref) => DetailOperationProvider());

class DetailOperationProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  DetailOperationModel? _detailOperationModel;

  bool _isLoading = false;

  Future<DetailOperationModel?> infoOperation({required int id}) async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.detailOperations(id);
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      print('response $response');
      return null;
    }

    _detailOperationModel = response;
    return response;
  }

  DetailOperationModel? get infoMecanoModel => _detailOperationModel;

  bool get isLoading => _isLoading;
}
