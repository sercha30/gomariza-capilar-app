import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/calendar_repository/calendar_repository.dart';

import '../../models/calendar/check_calendar_response.dart';

part 'check_calendar_event.dart';
part 'check_calendar_state.dart';

class CheckCalendarBloc extends Bloc<CheckCalendarEvent, CheckCalendarState> {
  final CalendarRepository calendarRepository;

  CheckCalendarBloc(this.calendarRepository)
      : super(CheckCalendarInitialState()) {
    on<DoCheckCalendarEvent>(_doCheckCalendarEvent);
  }

  void _doCheckCalendarEvent(
      DoCheckCalendarEvent event, Emitter<CheckCalendarState> emit) async {
    try {
      final checkCalendarResponse = await calendarRepository
          .checkCalendarAvailability(event.idService, event.monthNumber);
      emit(CheckCalendarSuccessState(checkCalendarResponse));
      return;
    } on Exception catch (e) {
      emit(CheckCalendarErrorState(e.toString()));
    }
  }
}
