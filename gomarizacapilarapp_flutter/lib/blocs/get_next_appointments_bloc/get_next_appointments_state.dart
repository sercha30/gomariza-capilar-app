part of 'get_next_appointments_bloc.dart';

abstract class GetNextAppointmentsState extends Equatable {
  const GetNextAppointmentsState();

  @override
  List<Object> get props => [];
}

class GetNextAppointmentsInitialState extends GetNextAppointmentsState {}

class GetNextAppointmentsLoadingState extends GetNextAppointmentsState {}

class GetNextAppointmentsSuccessState extends GetNextAppointmentsState {
  final List<AppointmentListResponse> getNextAppointmentsResponse;

  const GetNextAppointmentsSuccessState(this.getNextAppointmentsResponse);

  @override
  List<Object> get props => [getNextAppointmentsResponse];
}

class GetNextAppointmentsErrorState extends GetNextAppointmentsState {
  final String getNextAppointmentsMessage;

  const GetNextAppointmentsErrorState(this.getNextAppointmentsMessage);

  @override
  List<Object> get props => [getNextAppointmentsMessage];
}
