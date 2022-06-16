part of 'check_calendar_bloc.dart';

abstract class CheckCalendarState extends Equatable {
  const CheckCalendarState();

  @override
  List<Object> get props => [];
}

class CheckCalendarInitialState extends CheckCalendarState {}

class CheckCalendarLoadingState extends CheckCalendarState {}

class CheckCalendarSuccessState extends CheckCalendarState {
  final CheckCalendarResponse checkCalendarResponse;

  const CheckCalendarSuccessState(this.checkCalendarResponse);

  @override
  List<Object> get props => [checkCalendarResponse];
}

class CheckCalendarErrorState extends CheckCalendarState {
  final String checkCalendarMessage;

  const CheckCalendarErrorState(this.checkCalendarMessage);

  @override
  List<Object> get props => [checkCalendarMessage];
}
