import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_info_status_event.dart';
part 'user_info_status_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, InfoStates> {

  UserInfoBloc() : super(InfoStates.initial()) {

    on<ChangeUserModeEvent>(_changeModeHandler);

  }

  void _changeModeHandler(ChangeUserModeEvent event, Emitter<InfoStates> emit) {
    emit(state.copyWith(mode: event.mode));
  }



}
