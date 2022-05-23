part of 'me_bloc.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

class MeInitialState extends MeState {}

class MeLoadingState extends MeState {}

class MeSuccessState extends MeState {
  final MeResponse meResponse;

  const MeSuccessState(this.meResponse);

  @override
  List<Object> get props => [meResponse];
}

class MeErrorState extends MeState {
  final String message;

  const MeErrorState(this.message);

  @override
  List<Object> get props => [message];
}
