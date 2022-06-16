import 'dart:convert';

import 'package:flutter_gomariza_capilar_app/models/calendar/check_calendar_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/calendar_repository/calendar_repository.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../../utils/preferences/preferences_utils.dart';

class CalendarRepositoryImpl extends CalendarRepository {
  final headers = {
    'Authorization':
        'Bearer ${PreferenceUtils.getString(Constants.BEARER_TOKEN)}'
  };

  @override
  Future<CheckCalendarResponse> checkCalendarAvailability(
      String idService, int monthNumber) async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL +
            '/cita/freeAppointmentsCalendar?idServicio=' +
            idService +
            '&monthNumber=' +
            monthNumber.toString()),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return CheckCalendarResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get calendar availability');
    }
  }
}
