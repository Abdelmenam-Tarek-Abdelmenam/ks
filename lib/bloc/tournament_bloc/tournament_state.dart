// ignore_for_file: must_be_immutable

part of 'tournament_bloc.dart';

class TournamentState extends Equatable {
  List<Tournament> active;
  ShowData<Tournament> other;
  BlocStatus status;

  TournamentState({
    required this.active,
    required this.other,
    required this.status,
  });

  TournamentState copyWith(
          {ShowData<Tournament>? other,
          List<Tournament>? active,
          BlocStatus? status}) =>
      TournamentState(
        status: status ?? this.status,
        active: active ?? this.active,
        other: other ?? this.other,
      );

  factory TournamentState.initial() => TournamentState(
      active: const [], other: ShowData.empty(), status: BlocStatus.idle);

  @override
  List<Object> get props => [active.length, other.data.length, status];
}
