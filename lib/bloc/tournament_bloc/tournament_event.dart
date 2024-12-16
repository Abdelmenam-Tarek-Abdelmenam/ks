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
  final String? subId;
  final bool isInsertFlag;
  final String name;
  final String memberCount;
  final String supervisorName;
  final String city;
  final String country;
  final String age;
  final String teamImage;
  final String type;
  final bool playedChampionship;

  const RegisterTournamentEvent({
    required this.isInsertFlag,
    required this.subId,
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
        'flag_mon3m': isInsertFlag ? '1' : '2',
        'id_user': AuthBloc.user.id,
        'id_champ': tournamentId,
        'id_sub_champ': subId.toString(),
        'team_name': name,
        'team_num': memberCount,
        'team_manager': supervisorName,
        'team_city': city,
        'team_country': country,
        'team_range': age,
        'play_before': playedChampionship ? '0' : '1',
        'type_champ_sub': type,
        'team_photo': teamImage,
      };

  @override
  List<Object?> get props => [tournamentId];
}
