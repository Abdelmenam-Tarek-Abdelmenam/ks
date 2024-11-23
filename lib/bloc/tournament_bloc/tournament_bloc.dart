import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/show_data.dart';
import '../../data/models/tournament.dart';
import '../../domain_layer/repository_implementer/error_state.dart';
import '../../domain_layer/repository_implementer/tournament_repo.dart';
import '../status.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(TournamentState.initial()) {
    on<GetTournamentEvent>(_getDataHandler);
    on<GetMoreTournamentEvent>(_getMoreDataHandler);
    add(const GetTournamentEvent());
  }
  final TournamentRepository _repository = TournamentRepository();

  Future<void> _getDataHandler(GetTournamentEvent _, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));
    // Either<Failure, AllTournament> all =
    //     await _repository.getAllStore(state.other.end);
    List<Tournament> tournaments = Tournament.generateRandomTournaments;

    List<Tournament> active = tournaments.where((e) {
      return !e.isActive;
    }).toList();

    List<Tournament> other = tournaments.where((e) {
      return e.isActive;
    }).toList();


    emit(state.copyWith(
                  status: BlocStatus.getData,
                  other: ShowData(other),
                  active: active));

  //   all.fold(
  //       (_) => emit(state.copyWith(status: BlocStatus.error)),
  //       (data) => emit(state.copyWith(
  //           status: BlocStatus.getData,
  //           other: data.other,
  //           active: data.active)));
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _getMoreDataHandler(
      GetMoreTournamentEvent _, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.idle));
    if (state.other.isEnd) return;
    if (state.status == BlocStatus.gettingData) return;

    emit(state.copyWith(status: BlocStatus.idle));
    Either<Failure, ShowData<Tournament>> all =
        await _repository.getMoreStore(state.other);
    all.fold(
        (err) => err.show,
        (data) => emit(state.copyWith(
              status: BlocStatus.getData,
              other: data,
            )));
  }
}
