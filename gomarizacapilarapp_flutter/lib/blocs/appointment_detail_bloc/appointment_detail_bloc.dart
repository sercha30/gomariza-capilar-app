import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';

import '../../models/appointment/appointment_detail_response.dart';

part 'appointment_detail_event.dart';
part 'appointment_detail_state.dart';

class AppointmentDetailBloc
    extends Bloc<AppointmentDetailEvent, AppointmentDetailState> {
  final AppointmentRepository appointmentRepository;

  AppointmentDetailBloc(this.appointmentRepository)
      : super(AppointmentDetailInitState()) {
    on<GetAppointmentDetailEvent>(_getAppointmentDetailEvent);
  }

  void _getAppointmentDetailEvent(GetAppointmentDetailEvent event,
      Emitter<AppointmentDetailState> emit) async {
    try {
      final appointmentDetailResponse = await appointmentRepository
          .getDetailedAppointment(event.idAppointment);
      emit(AppointmentDetailSuccessState(appointmentDetailResponse));
      return;
    } on Exception catch (e) {
      emit(AppointmentDetailErrorState(e.toString()));
    }
  }
}
