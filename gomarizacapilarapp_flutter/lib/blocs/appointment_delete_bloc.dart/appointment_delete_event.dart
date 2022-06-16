part of 'appointment_delete_bloc.dart';

abstract class AppointmentDeleteEvent extends Equatable {
  const AppointmentDeleteEvent();

  @override
  List<Object> get props => [];
}

class DoDeleteAppointmentEvent extends AppointmentDeleteEvent {
  final String appointmentId;

  const DoDeleteAppointmentEvent(this.appointmentId);
}
