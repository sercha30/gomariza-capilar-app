import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';

import '../../models/appointment/appointment_dto.dart';

part 'appointment_create_event.dart';
part 'appointment_create_state.dart';

class AppointmentCreateBloc
    extends Bloc<AppointmentCreateEvent, AppointmentCreateState> {
  final AppointmentRepository appointmentRepository;

  AppointmentCreateBloc(this.appointmentRepository)
      : super(AppointmentCreateInitialState()) {
    on<DoCreateAppointmentEvent>(_doCreateAppointmentEvent);
  }

  void _doCreateAppointmentEvent(DoCreateAppointmentEvent event,
      Emitter<AppointmentCreateState> emit) async {
    try {
      final appointmentCreateResponse =
          await appointmentRepository.createAppointment(event.appointmentDto);
      emit(AppointmentCreateSuccessState(appointmentCreateResponse));
    } on Exception catch (e) {
      emit(AppointmentCreateErrorState(e.toString()));
    }
  }
}
