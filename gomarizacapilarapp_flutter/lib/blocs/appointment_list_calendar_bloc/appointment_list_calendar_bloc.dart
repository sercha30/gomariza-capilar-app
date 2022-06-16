import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';

import '../../models/appointment/appointment_calendar_list_response.dart';

part 'appointment_list_calendar_state.dart';
part 'appointment_list_calendar_event.dart';

class AppointmentListCalendarBloc
    extends Bloc<AppointmentListCalendarEvent, AppointmentListCalendarState> {
  final AppointmentRepository appointmentRepository;

  AppointmentListCalendarBloc(this.appointmentRepository)
      : super(AppointmentListCalendarInitialState()) {
    on<GetAllAppointmentsCalendarEvent>(_getAllAppointmentsCalendarEvent);
  }

  void _getAllAppointmentsCalendarEvent(AppointmentListCalendarEvent,
      Emitter<AppointmentListCalendarState> emit) async {
    try {
      final getAllAppointmentsListCalendarResponse =
          await appointmentRepository.getAllAppointmentsCalendar();
      emit(AppointmentListCalendarSuccessState(
          getAllAppointmentsListCalendarResponse));
      return;
    } on Exception catch (e) {
      emit(AppointmentListCalendarErrorState(e.toString()));
    }
  }
}
