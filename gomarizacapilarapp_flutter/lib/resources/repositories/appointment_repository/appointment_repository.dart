import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_list_response.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentListResponse>> getNextAppointments();
}
