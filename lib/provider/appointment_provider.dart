import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/rendez_vous_model.dart';
import '../networkService/repository/api_repository.dart';

final rdvProvider =
ChangeNotifierProvider((ref) => AppointmentProvider());

class AppointmentProvider extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();

  Future<RendezVousModel?> appoint(
      {required int client_id, required int mecanicien_id, required String date_rdv, required String hour_start_rdv, required String hour_end_rdv}) async {
    final response = await _apiRepository.appointmentCustomer(client_id, mecanicien_id, date_rdv, hour_start_rdv, hour_end_rdv);
    notifyListeners();
    if (response == null) {
      return null;
    }

    return response;
  }
}