part of 'tournament_bloc.dart';

abstract class TournamentEvent extends Equatable {
  const TournamentEvent();
  @override
  List<Object?> get props => [];
}

class GetTournamentEvent extends TournamentEvent {
  const GetTournamentEvent();

  @override
  List<Object?> get props => [];
}

class GetMoreTournamentEvent extends TournamentEvent {
  const GetMoreTournamentEvent();

  @override
  List<Object?> get props => [];
}
