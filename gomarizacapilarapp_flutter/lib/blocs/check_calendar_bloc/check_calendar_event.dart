part of 'check_calendar_bloc.dart';

abstract class CheckCalendarEvent extends Equatable {
  const CheckCalendarEvent();

  @override
  List<Object> get props => [];
}

class DoCheckCalendarEvent extends CheckCalendarEvent {
  final String idService;
  final int monthNumber;

  const DoCheckCalendarEvent(this.idService, this.monthNumber);

  @override
  List<Object> get props => [];
}
