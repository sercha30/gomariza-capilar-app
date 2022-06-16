part of 'appointment_create_bloc.dart';

abstract class AppointmentCreateEvent extends Equatable {
  const AppointmentCreateEvent();

  @override
  List<Object> get props => [];
}

class DoCreateAppointmentEvent extends AppointmentCreateEvent {
  final AppointmentDto appointmentDto;

  const DoCreateAppointmentEvent(this.appointmentDto);
}
