part of 'service_detail_bloc.dart';

abstract class ServiceDetailState extends Equatable {
  const ServiceDetailState();

  @override
  List<Object> get props => [];
}

class ServiceDetailInitialState extends ServiceDetailState {}

class ServiceDetailLoadingState extends ServiceDetailState {}

class ServiceDetailSuccessState extends ServiceDetailState {
  final ServiceDetailResponse serviceDetailResponse;

  const ServiceDetailSuccessState(this.serviceDetailResponse);

  @override
  List<Object> get props => [serviceDetailResponse];
}

class ServiceDetailErrorState extends ServiceDetailState {
  final String message;

  const ServiceDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}
