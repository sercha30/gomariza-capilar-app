import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/service/service_list_response.dart';
import '../../resources/repositories/service_repository/service_repository.dart';

part 'service_list_event.dart';
part 'service_list_state.dart';

class ServiceListBloc extends Bloc<ServiceListEvent, ServiceListState> {
  final ServiceRepository serviceRepository;

  ServiceListBloc(this.serviceRepository) : super(ServiceListInitialState()) {
    on<GetServiceListEvent>(_getServiceListEvent);
  }

  void _getServiceListEvent(
      ServiceListEvent event, Emitter<ServiceListState> emit) async {
    try {
      final getServiceListResponse = await serviceRepository.getServicesList();
      emit(ServiceListSuccessState(getServiceListResponse));
      return;
    } on Exception catch (e) {
      emit(ServiceListErrorState(e.toString()));
    }
  }
}
