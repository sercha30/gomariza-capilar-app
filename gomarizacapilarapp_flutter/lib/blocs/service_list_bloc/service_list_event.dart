part of 'service_list_bloc.dart';

abstract class ServiceListEvent extends Equatable {
  const ServiceListEvent();

  @override
  List<Object> get props => [];
}

class GetServiceListEvent extends ServiceListEvent {
  const GetServiceListEvent();

  @override
  List<Object> get props => [];
}
