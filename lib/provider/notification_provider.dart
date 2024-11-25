import 'package:africasa_mecano/domain/models/list_operation_model.dart';
import 'package:africasa_mecano/domain/models/notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../networkService/repository/api_repository.dart';

final notificationProvider = ChangeNotifierProvider((ref) => NotificationProvider());

class NotificationProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  NotificationModel? _notificationModel;

  bool _isLoading = false;

  Future<NotificationModel?> getListNotification() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.listNotification();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _notificationModel = response;

    return _notificationModel;
  }

  NotificationModel? get notificationModel => _notificationModel;

  bool get isLoading => _isLoading;
}