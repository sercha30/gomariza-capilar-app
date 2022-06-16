part of 'appointment_list_calendar_bloc.dart';

abstract class AppointmentListCalendarEvent extends Equatable {
  const AppointmentListCalendarEvent();

  @override
  List<Object> get props => [];
}

class GetAllAppointmentsCalendarEvent extends AppointmentListCalendarEvent {
  const GetAllAppointmentsCalendarEvent();

  @override
  List<Object> get props => [];
}
