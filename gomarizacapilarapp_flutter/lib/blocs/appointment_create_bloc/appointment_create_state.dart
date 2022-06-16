part of 'appointment_create_bloc.dart';

abstract class AppointmentCreateState extends Equatable {
  const AppointmentCreateState();

  @override
  List<Object> get props => [];
}

class AppointmentCreateInitialState extends AppointmentCreateState {}

class AppointmentCreateLoadingState extends AppointmentCreateState {}

class AppointmentCreateSuccessState extends AppointmentCreateState {
  final bool appointmentCreateResponse;

  const AppointmentCreateSuccessState(this.appointmentCreateResponse);

  @override
  List<Object> get props => [appointmentCreateResponse];
}

class AppointmentCreateErrorState extends AppointmentCreateState {
  final String message;

  const AppointmentCreateErrorState(this.message);

  @override
  List<Object> get props => [message];
}
