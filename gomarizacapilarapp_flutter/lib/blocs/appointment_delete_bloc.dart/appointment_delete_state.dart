part of 'appointment_delete_bloc.dart';

abstract class AppointmentDeleteState extends Equatable {
  const AppointmentDeleteState();

  @override
  List<Object> get props => [];
}

class AppointmentDeleteInitialState extends AppointmentDeleteState {}

class AppointmentDeleteLoadingState extends AppointmentDeleteState {}

class AppointmentDeleteSuccessState extends AppointmentDeleteState {
  final bool appointmentDeleteResponse;

  const AppointmentDeleteSuccessState(this.appointmentDeleteResponse);

  @override
  List<Object> get props => [appointmentDeleteResponse];
}

class AppointmentDeleteErrorState extends AppointmentDeleteState {
  final String message;

  const AppointmentDeleteErrorState(this.message);

  @override
  List<Object> get props => [message];
}
