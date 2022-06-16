import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';

part 'appointment_delete_event.dart';
part 'appointment_delete_state.dart';

class AppointmentDeleteBloc
    extends Bloc<AppointmentDeleteEvent, AppointmentDeleteState> {
  final AppointmentRepository appointmentRepository;

  AppointmentDeleteBloc(this.appointmentRepository)
      : super(AppointmentDeleteInitialState()) {
    on<DoDeleteAppointmentEvent>(_doDeleteAppointmentEvent);
  }

  void _doDeleteAppointmentEvent(DoDeleteAppointmentEvent event,
      Emitter<AppointmentDeleteState> emit) async {
    try {
      final appointmentDeleteResponse =
          await appointmentRepository.deleteAppointment(event.appointmentId);
      emit(AppointmentDeleteSuccessState(appointmentDeleteResponse));
      return;
    } on Exception catch (e) {
      emit(AppointmentDeleteErrorState(e.toString()));
    }
  }
}
