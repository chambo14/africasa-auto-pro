
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/info_mecano_model.dart';
import '../networkService/repository/api_repository.dart';


final detailMecanicianProvider = ChangeNotifierProvider((ref) => DetailProvider());

class DetailProvider extends ChangeNotifier {
final ApiRepository _apiRepository = ApiRepository();

InfoMecanoModel? _infoMecanoModel;

bool _isLoading = false;

Future<InfoMecanoModel?> infoMecano({required int id}) async {
_isLoading = true;
notifyListeners();
var response = await _apiRepository.detailMecanicien(id);
_isLoading = false;
notifyListeners();
if (response == null) {
print('response $response');
return null;
}

_infoMecanoModel = response;
print("Quelle est le contenu de response $response");
return response;
}

InfoMecanoModel? get infoMecanoModel => _infoMecanoModel;

bool get isLoading => _isLoading;
}
