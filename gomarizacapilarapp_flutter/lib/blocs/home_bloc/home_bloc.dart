import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';

import '../../models/appointment/appointment_list_response.dart';
import '../../models/auth/me/me_response.dart';
import '../../models/service/service_list_response.dart';
import '../../resources/repositories/appointment_repository/appointment_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppointmentRepository appointmentRepository;
  final AuthRepository authRepository;
  final ServiceRepository serviceRepository;

  HomeBloc(
      this.appointmentRepository, this.authRepository, this.serviceRepository)
      : super(HomeInitialState()) {
    on<HomeEvent>(_loadHomeScreenEvent);
  }

  void _loadHomeScreenEvent(HomeEvent event, Emitter<HomeState> emit) async {
    try {
      final getNextAppointmentsResponse =
          await appointmentRepository.getNextAppointments();
      final getMeResponse = await authRepository.getLoggedUser();
      final getServiceList = await serviceRepository.getServicesList();
      emit(HomeSuccessState(
          getMeResponse, getNextAppointmentsResponse, getServiceList));
      return;
    } on Exception catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
}
