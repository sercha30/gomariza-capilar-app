part of 'service_list_bloc.dart';

abstract class ServiceListState extends Equatable {
  const ServiceListState();

  @override
  List<Object> get props => [];
}

class ServiceListInitialState extends ServiceListState {}

class ServiceListLoadingState extends ServiceListState {}

class ServiceListSuccessState extends ServiceListState {
  final List<ServiceListResponse> serviceListResponse;

  const ServiceListSuccessState(this.serviceListResponse);

  @override
  List<Object> get props => [serviceListResponse];
}

class ServiceListErrorState extends ServiceListState {
  final String serviceListMessage;

  const ServiceListErrorState(this.serviceListMessage);

  @override
  List<Object> get props => [serviceListMessage];
}
