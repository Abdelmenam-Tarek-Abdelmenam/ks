// ignore_for_file: must_be_immutable

part of 'tournament_bloc.dart';

class TournamentState extends Equatable {
  List<Tournament> active;
  List<Tournament> other;
  BlocStatus status;
  BlocStatus registrationStatus;
  BlocStatus checkStatus;
  String? clickedId ;

  TournamentState({
    required this.active,
    required this.other,
    required this.status,
    required this.registrationStatus,
    required this.checkStatus,
    this.clickedId,
  });

  TournamentState copyWith(
          {List<Tournament>? other,
          List<Tournament>? active,
          BlocStatus? registrationStatus,
          BlocStatus? checkStatus,
            String? clickedId,
          BlocStatus? status}) =>
      TournamentState(
        status: status ?? this.status,
        registrationStatus: registrationStatus ?? this.registrationStatus,
        checkStatus: checkStatus ?? this.checkStatus,
        active: active ?? this.active,
        clickedId: clickedId ?? this.clickedId,
        other: other ?? this.other,
      );

  factory TournamentState.initial() => TournamentState(
      active: const [],
      other: const [],
      status: BlocStatus.idle,
      registrationStatus: BlocStatus.idle,
      checkStatus: BlocStatus.idle);

  @override
  List<Object> get props => [active.length, other.length, status , checkStatus,registrationStatus];
}
