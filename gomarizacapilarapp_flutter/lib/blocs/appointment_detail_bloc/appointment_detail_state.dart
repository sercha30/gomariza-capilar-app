part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailState extends Equatable {
  const AppointmentDetailState();

  @override
  List<Object> get props => [];
}

class AppointmentDetailInitState extends AppointmentDetailState {}

class AppointmentDetailLoadingState extends AppointmentDetailState {}

class AppointmentDetailSuccessState extends AppointmentDetailState {
  final AppointmentDetailResponse appointmentDetailResponse;

  const AppointmentDetailSuccessState(this.appointmentDetailResponse);

  @override
  List<Object> get props => [appointmentDetailResponse];
}

class AppointmentDetailErrorState extends AppointmentDetailState {
  final String message;

  const AppointmentDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}
