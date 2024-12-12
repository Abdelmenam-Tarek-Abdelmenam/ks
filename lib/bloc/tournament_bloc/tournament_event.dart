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

class RegisterTournamentEvent extends TournamentEvent {
  final String tournamentId;
  final String name;
  final String memberCount;
  final String supervisorName;
  final String city;
  final String country;
  final String age;
  final File? teamImage;
  final bool playedChampionship;
  final bool wonChampionship;

  const RegisterTournamentEvent({
    required this.tournamentId,
    required this.name,
    required this.memberCount,
    required this.supervisorName,
    required this.city,
    required this.country,
    required this.age,
    required this.teamImage,
    required this.playedChampionship,
    required this.wonChampionship,
  });

  Map<String, String> get toJson => {
        'tournamentId': tournamentId,
        'userId': AuthBloc.user.id,
        'name': name,
        'memberCount': memberCount,
        'supervisorName': supervisorName,
        'city': city,
        'country': country,
        'age': age,
        'teamImage':
            teamImage?.readAsStringSync()??"Null",
        'playedChampionship': playedChampionship? '0' : '1',
        'wonChampionship': wonChampionship? '0' : '1',
      };

  @override
  List<Object?> get props => [tournamentId];
}
