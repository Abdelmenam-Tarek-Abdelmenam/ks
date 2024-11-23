import 'package:either_dart/either.dart';
import 'package:final_projects/domain_layer/date_extensions.dart';

import '../../data/data_sources/web_services/mongo_repository.dart';
import '../../data/models/show_data.dart';

import '../../data/models/tournament.dart';
import 'error_state.dart';

class TournamentRepository {
  Future<Either<Failure, AllTournament>> getAllStore(int end) async {
    try {
      List<Map<String, dynamic>?> data =
          await MongoDatabase.instance.getTournaments(0, end);

      return Right(AllTournament.fromJson(data));
    } catch (_) {
      return const Left(
          Failure("Error happened while getting tournament data"));
    }
  }

  Future<Either<Failure, ShowData<Tournament>>> getMoreStore(
      ShowData<Tournament> old) async {
    try {
      old.getNext();
      List<Map<String, dynamic>?> storeData =
          await MongoDatabase.instance.getTournaments(old.start, old.end);
      List<Tournament> tournaments =
          storeData.map((e) => Tournament.fromJson(e!)).toList();
      old.data.addAll(tournaments);
      return Right(old);
    } catch (_) {
      return const Left(
          Failure("Error happened while getting tournament data"));
    }
  }
}

class AllTournament {
  final ShowData<Tournament> other;
  final List<Tournament> active;

  const AllTournament({
    required this.active,
    required this.other,
  });

  factory AllTournament.fromJson(List<Map<String, dynamic>?> data) {
    List<Tournament> all = data.map((e) => Tournament.fromJson(e!)).toList();
    List<Tournament> active = all
        .where((element) => element.date == DateTime.now().formatDate)
        .toList();
    all.removeWhere((element) => element.date == DateTime.now().formatDate);
    return AllTournament(active: active, other: ShowData(all));
  }
}
