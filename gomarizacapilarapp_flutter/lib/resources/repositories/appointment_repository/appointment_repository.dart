import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_calendar_list_response.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_list_response.dart';

import '../../../models/appointment/appointment_dto.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentListResponse>> getNextAppointments();
  Future<List<AppointmentCalendarListResponse>> getAllAppointmentsCalendar();
  Future<AppointmentDetailResponse> getDetailedAppointment(
      String appointmentId);
  Future<bool> deleteAppointment(String appointmentId);
  Future<bool> createAppointment(AppointmentDto appointmentDto);
}
