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

class CheckRegisteredEVent extends TournamentEvent {
  final String id;
  const CheckRegisteredEVent(this.id);

  @override
  List<Object?> get props => [id];
}

class RegisterTournamentEvent extends TournamentEvent {
  final String tournamentId;
  final String name;
  final String memberCount;
  final String supervisorName;
  final String city;
  final String country;
  final String age;
  final File teamImage;
  final String type;
  final bool playedChampionship;

  const RegisterTournamentEvent({
    required this.tournamentId,
    required this.name,
    required this.memberCount,
    required this.supervisorName,
    required this.city,
    required this.country,
    required this.type,
    required this.age,
    required this.teamImage,
    required this.playedChampionship,
  });

  Map<String, String> get toJson => {
        'id_user': AuthBloc.user.id,
        'id_champ': tournamentId,
        'team_name': name,
        'team_num': memberCount,
        'team_manager': supervisorName,
        'team_city': city,
        'team_country': country,
        'team_photo': convertImageToBase64(teamImage),
        'team_range': age,
        'before_play': playedChampionship ? '0' : '1',
        'sub_champ_pay': '0',
        'sub_champ_type': type,
      };

  @override
  List<Object?> get props => [tournamentId];
}
