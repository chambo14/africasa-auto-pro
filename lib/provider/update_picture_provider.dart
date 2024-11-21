import 'dart:io';

import 'package:africasa_mecano/domain/models/update_picture_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../networkService/repository/api_repository.dart';

final pictureProvider =
ChangeNotifierProvider((ref) => UpdatePictureProvider());

class UpdatePictureProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<UpdatePictureModel?> updatePicture(
      {required File picture}) async {
    final response = await _apiRepository.UpdatePictureProfile(picture);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}