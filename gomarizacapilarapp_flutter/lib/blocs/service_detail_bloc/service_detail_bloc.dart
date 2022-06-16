import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/models/service/service_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';

part 'service_detail_event.dart';
part 'service_detail_state.dart';

class ServiceDetailBloc extends Bloc<ServiceDetailEvent, ServiceDetailState> {
  final ServiceRepository serviceRepository;

  ServiceDetailBloc(this.serviceRepository)
      : super(ServiceDetailInitialState()) {
    on<GetServiceDetailEvent>(_getServiceDetailEvent);
  }

  void _getServiceDetailEvent(
      GetServiceDetailEvent event, Emitter<ServiceDetailState> emit) async {
    try {
      final serviceDetailResponse =
          await serviceRepository.getServiceDetail(event.idService);
      emit(ServiceDetailSuccessState(serviceDetailResponse));
      return;
    } on Exception catch (e) {
      emit(ServiceDetailErrorState(e.toString()));
    }
  }
}
