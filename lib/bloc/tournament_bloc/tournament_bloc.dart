import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:final_projects/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:final_projects/presentation/shared/widget/error_image.dart';
import '../../data/models/tournament.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/tournament_repo.dart';
import '../status.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(TournamentState.initial()) {
    on<GetTournamentEvent>(_getDataHandler);
    on<RegisterTournamentEvent>(_registerDataHandler);
    on<CheckRegisteredEVent>(_checkRegisteredHandler);
    add(const GetTournamentEvent());
  }
  final TournamentRepository _repository = TournamentRepository();

  Future<void> _getDataHandler(GetTournamentEvent _, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));
    Either<Failure, AllTournament> all = await _repository.getTournament();
    all.fold((err) {
      err.show;
      emit(state.copyWith(status: BlocStatus.error));
    },
        (data) => emit(state.copyWith(
            status: BlocStatus.getData,
            other: data.other,
            active: data.active)));
  }

  Future<void> _registerDataHandler(
      RegisterTournamentEvent event, Emitter emit) async {
    emit(state.copyWith(registrationStatus: BlocStatus.gettingData));

    Either<Failure, void> all =
        await _repository.registerTournament(event.toJson);
    all.fold((err) {
      err.show;
      emit(state.copyWith(registrationStatus: BlocStatus.error));
    },
        (data) => emit(state.copyWith(
              registrationStatus: BlocStatus.getData,
            )));
  }

  Future<void> _checkRegisteredHandler(
      CheckRegisteredEVent event, Emitter emit) async {
      state.active.where((e) => e.id == event.id).first.isRegistered = true;
    emit(state.copyWith(
        checkStatus: BlocStatus.getData, clickedId: event.id));

    // Either<Failure, bool> all = await _repository.checkRegistered(event.id);
    // all.fold((err) {
    //   err.show;
    //   emit(state.copyWith(checkStatus: BlocStatus.error));
    // }, (data) {
    //   state.active.where((e) => e.id == event.id).first.isRegistered = data;
    //   emit(state.copyWith(
    //     checkStatus: BlocStatus.getData,
    //   ));
    // });
  }
}
