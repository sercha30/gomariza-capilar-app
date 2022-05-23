import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gomariza_capilar_app/models/auth/me/me_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';

import '../../models/auth/me/me_response.dart';

part 'me_event.dart';
part 'me_state.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final AuthRepository authRepository;

  MeBloc(this.authRepository) : super(MeInitialState()) {
    on<GetLoggedUserEvent>(_getLoggedUserEvent);
  }

  void _getLoggedUserEvent(
      GetLoggedUserEvent event, Emitter<MeState> emit) async {
    try {
      final meResponse = await authRepository.getLoggedUser();
      emit(MeSuccessState(meResponse));
      return;
    } on Exception catch (e) {
      emit(MeErrorState(e.toString()));
    }
  }
}
