import 'dart:convert';

import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_list_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';
import 'package:http/http.dart' as http;

class AppointmentRepositoryImpl extends AppointmentRepository {
  final headers = {
    'Authorization':
        'Bearer ${PreferenceUtils.getString(Constants.BEARER_TOKEN)}'
  };

  @override
  Future<List<AppointmentListResponse>> getNextAppointments() async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL + '/cita/nextAppointments'),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return List.from(json.decode(response.body))
          .map((e) => AppointmentListResponse.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to get next appointments');
    }
  }
}
