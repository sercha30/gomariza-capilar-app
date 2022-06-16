part of 'appointment_list_calendar_bloc.dart';

abstract class AppointmentListCalendarState extends Equatable {
  const AppointmentListCalendarState();

  @override
  List<Object> get props => [];
}

class AppointmentListCalendarInitialState extends AppointmentListCalendarState {
}

class AppointmentListCalendarLoadingState extends AppointmentListCalendarState {
}

class AppointmentListCalendarSuccessState extends AppointmentListCalendarState {
  final List<AppointmentCalendarListResponse> appointmentListCalendarResponse;

  const AppointmentListCalendarSuccessState(
      this.appointmentListCalendarResponse);

  @override
  List<Object> get props => [appointmentListCalendarResponse];
}

class AppointmentListCalendarErrorState extends AppointmentListCalendarState {
  final String appointmentListMessage;

  const AppointmentListCalendarErrorState(this.appointmentListMessage);

  @override
  List<Object> get props => [appointmentListMessage];
}
