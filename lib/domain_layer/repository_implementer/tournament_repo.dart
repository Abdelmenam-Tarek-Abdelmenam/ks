import 'package:either_dart/either.dart';

import '../../data/data_sources/web_services/api_repository.dart';

import '../../data/models/tournament.dart';
import 'error_state.dart';

class TournamentRepository {
  Future<Either<Failure, AllTournament>> getTournament() async {
    try {
      List<Map<String, dynamic>> data = await ApiCall.instance.getTournament();
      return Right(AllTournament.fromJson(data));
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء تحميل البيانات"));
    }
  }

  Future<Either<Failure, void>> registerTournament(Map<String,String> userData) async {
    if(userData['name']!.isEmpty){
      return const Left(Failure("راجع البيانات المدخله"));
    }

    try {
      bool state = await ApiCall.instance.registerTournament(userData);
      if (!state) return const Left(Failure("حدث خطأ اثناء تحميل البيانات"));
      return const Right(null);
    } on Failure catch (err) {
      return Left(err);
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء تحميل البيانات"));
    }
  }
}

class AllTournament {
  final List<Tournament> other;
  final List<Tournament> active;

  const AllTournament({
    required this.active,
    required this.other,
  });

  factory AllTournament.fromJson(List<Map<String, dynamic>?> data) {
    List<Tournament> all = data.map((e) => Tournament.fromJson(e!)).toList();

    List<Tournament> active = all.where((e) {
      return !e.isActive;
    }).toList();

    List<Tournament> other = all.where((e) {
      return e.isActive;
    }).toList();

    return AllTournament(active: active, other: other);
  }
}
