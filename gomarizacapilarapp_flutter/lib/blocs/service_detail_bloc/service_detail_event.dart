part of 'service_detail_bloc.dart';

abstract class ServiceDetailEvent extends Equatable {
  const ServiceDetailEvent();

  @override
  List<Object> get props => [];
}

class GetServiceDetailEvent extends ServiceDetailEvent {
  final String idService;

  const GetServiceDetailEvent(this.idService);

  @override
  List<Object> get props => [];
}
