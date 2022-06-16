import 'dart:convert';

import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_calendar_list_response.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_dto.dart';
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

  @override
  Future<List<AppointmentCalendarListResponse>>
      getAllAppointmentsCalendar() async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL + '/cita/allAppointmentsCalendar'),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return List.from(json.decode(response.body))
          .map((e) => AppointmentCalendarListResponse.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to get appointments');
    }
  }

  @override
  Future<AppointmentDetailResponse> getDetailedAppointment(
      String appointmentId) async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL + '/cita/citaDetail/' + appointmentId),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return AppointmentDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get appointment detail');
    }
  }

  @override
  Future<bool> deleteAppointment(String appointmentId) async {
    final response = await http.delete(
        Uri.parse(Constants.API_BASE_URL + '/cita/deleteCita/' + appointmentId),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_NO_CONTENT) {
      return true;
    } else {
      throw Exception('Failed to delete appointment');
    }
  }

  @override
  Future<bool> createAppointment(AppointmentDto appointmentDto) async {
    final response = await http.post(
        Uri.parse(Constants.API_BASE_URL + '/cita/newAppointment'),
        headers: headers,
        body: jsonEncode(appointmentDto.toJson()));

    if (response.statusCode == Constants.RESPONSE_CREATED) {
      return true;
    } else {
      throw Exception('Failed to create appointment');
    }
  }
}
