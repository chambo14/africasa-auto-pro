
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/user_info_model.dart';
import '../networkService/repository/api_repository.dart';

final userProvider = ChangeNotifierProvider((ref) => UserInfoProvider());

class UserInfoProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  UserInfoModel? _userInfoModel;

  bool _isLoading = false;

  Future<UserInfoModel?> infoUserConnected() async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.getInfoUser();
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      return null;
    }

    _userInfoModel = response;
  }

  UserInfoModel? get userInfoModel => _userInfoModel;

  bool get isLoading => _isLoading;
}