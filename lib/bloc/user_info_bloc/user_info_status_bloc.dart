import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';

part 'user_info_status_event.dart';
part 'user_info_status_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, InfoStates> {
  UserInfoBloc() : super(InfoStates.initial()) {
    on<ChangeUserModeEvent>(_changeModeHandler);
    on<RegisterDataEvent>(_registerDataHandler);
  }

  final SigningRepository _repository = SigningRepository();

  void _changeModeHandler(ChangeUserModeEvent event, Emitter<InfoStates> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  Future<void> _registerDataHandler(RegisterDataEvent event, Emitter<InfoStates> emit) async {
    emit(state.copyWith(status: InfoStatus.loading));

    Either<Failure, void> all =
        await _repository.editUser(event.toJson);
    all.fold((err) {
      err.show;
      emit(state.copyWith(status: InfoStatus.error));
    },
        (data) => emit(state.copyWith(
              status: InfoStatus.done,
            )));
  }
}
