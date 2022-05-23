part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final MeResponse meResponse;
  final List<AppointmentListResponse> appointmentListResponse;
  final List<ServiceListResponse> serviceListResponse;

  const HomeSuccessState(
      this.meResponse, this.appointmentListResponse, this.serviceListResponse);

  @override
  List<Object> get props =>
      [meResponse, appointmentListResponse, serviceListResponse];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
