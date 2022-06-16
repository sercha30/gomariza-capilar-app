part of 'appointment_detail_bloc.dart';

abstract class AppointmentDetailEvent extends Equatable {
  const AppointmentDetailEvent();

  @override
  List<Object> get props => [];
}

class GetAppointmentDetailEvent extends AppointmentDetailEvent {
  final String idAppointment;

  const GetAppointmentDetailEvent(this.idAppointment);

  @override
  List<Object> get props => [];
}
