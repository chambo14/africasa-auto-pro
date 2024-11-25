
import 'package:africasa_mecano/domain/models/detail_notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/detail_appointment_model.dart';
import '../networkService/repository/api_repository.dart';


final detailNotificationProvider = ChangeNotifierProvider((ref) => DetailNotificationProvider());

class DetailNotificationProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  DetailNotificationModel? _detailNotificationModel;

  bool _isLoading = false;

  Future<DetailNotificationModel?> infoNotification({required int id}) async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.detailNotification(id);
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      print('response $response');
      return null;
    }
    _detailNotificationModel = response;

    return response;
  }

  DetailNotificationModel? get detailNotificationModel => _detailNotificationModel;

  bool get isLoading => _isLoading;
}
