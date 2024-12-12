// ignore_for_file: must_be_immutable

part of 'tournament_bloc.dart';

class TournamentState extends Equatable {
  List<Tournament> active;
  List<Tournament> other;
  BlocStatus status;
  BlocStatus registrationStatus;

  TournamentState({
    required this.active,
    required this.other,
    required this.status,
    required this.registrationStatus,
  });

  TournamentState copyWith(
          {List<Tournament>? other,
          List<Tournament>? active,
            BlocStatus? registrationStatus,
          BlocStatus? status}) =>
      TournamentState(
        status: status ?? this.status,
        registrationStatus: registrationStatus ?? this.registrationStatus,
        active: active ?? this.active,
        other: other ?? this.other,
      );

  factory TournamentState.initial() => TournamentState(
      active: const [], other: const [], status: BlocStatus.idle , registrationStatus : BlocStatus.idle);

  @override
  List<Object> get props => [active.length, other.length, status];
}
