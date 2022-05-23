import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_list_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';

part 'get_next_appointments_event.dart';
part 'get_next_appointments_state.dart';

class GetNextAppointmentsBloc
    extends Bloc<GetNextAppointmentsEvent, GetNextAppointmentsState> {
  final AppointmentRepository appointmentRepository;

  GetNextAppointmentsBloc(this.appointmentRepository)
      : super(GetNextAppointmentsInitialState()) {
    on<GetNextAppointmentsEvent>(_getNextAppointmentsEvent);
  }

  void _getNextAppointmentsEvent(GetNextAppointmentsEvent event,
      Emitter<GetNextAppointmentsState> emit) async {
    try {
      final getNextAppointmentsResponse =
          await appointmentRepository.getNextAppointments();
      emit(GetNextAppointmentsSuccessState(getNextAppointmentsResponse));
      return;
    } on Exception catch (e) {
      emit(GetNextAppointmentsErrorState(e.toString()));
    }
  }
}
