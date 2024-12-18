import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:final_projects/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:final_projects/data/data_sources/pref_repository.dart';
import 'package:final_projects/data/models/app_user.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/sigining_repo.dart';

part 'user_info_status_event.dart';
part 'user_info_status_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, InfoStates> {
  UserInfoBloc() : super(InfoStates.initial()) {
    on<ChangeUserModeEvent>(_changeModeHandler);
    on<RegisterDataEvent>(_registerDataHandler);
    on<ChangeUserEvent>(_changeUserHandler);
  }

  final SigningRepository _repository = SigningRepository();

  void _changeUserHandler(ChangeUserEvent event, Emitter<InfoStates> emit) {
    emit(state.copyWith(status: InfoStatus.loading));
    AuthBloc.user.verified = event.isActive;
    PreferenceRepository.putData(value: AuthBloc.user.toJson, key: PreferenceKey.userData);
    emit(state.copyWith(status: InfoStatus.initial));
  }

  void _changeModeHandler(ChangeUserModeEvent event, Emitter<InfoStates> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  Future<void> _registerDataHandler(
      RegisterDataEvent event, Emitter<InfoStates> emit) async {
    emit(state.copyWith(status: InfoStatus.loading));

    Either<Failure, void> all = await _repository.editUser(event.toJson);
    await all.fold((err) {
      err.show;
      emit(state.copyWith(status: InfoStatus.error));
    }, (data) async {
      AuthBloc.user = event.temp;
      PreferenceRepository.putData(
          value: event.temp.toJson, key: PreferenceKey.userData);
      emit(state.copyWith(
        status: InfoStatus.done,
      ));
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(
        status: InfoStatus.initial,
      ));
    });
  }
}
