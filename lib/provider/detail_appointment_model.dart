
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/detail_appointment_model.dart';
import '../networkService/repository/api_repository.dart';


final detailAppointmentProvider = ChangeNotifierProvider((ref) => DetailAppointmentProvider());

class DetailAppointmentProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  DetailAppointmentModel? _detailAppointmentModel;

  bool _isLoading = false;

  Future<DetailAppointmentModel?> infoAppointment({required int id}) async {
    _isLoading = true;
    notifyListeners();
    var response = await _apiRepository.detailAppointment(id);
    _isLoading = false;
    notifyListeners();
    if (response == null) {
      print('response $response');
      return null;
    }
  _detailAppointmentModel = response;

    return response;
  }

  DetailAppointmentModel? get detailAppointment => _detailAppointmentModel;

  bool get isLoading => _isLoading;
}
