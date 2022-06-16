import 'package:flutter_gomariza_capilar_app/models/calendar/check_calendar_response.dart';

abstract class CalendarRepository {
  Future<CheckCalendarResponse> checkCalendarAvailability(
      String idService, int monthNumber);
}
