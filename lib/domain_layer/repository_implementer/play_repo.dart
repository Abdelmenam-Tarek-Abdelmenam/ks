import 'package:either_dart/either.dart';
import '../../data/models/matches.dart';
import '../../bloc/auth_bloc/auth_status_bloc.dart';

import '../../data/data_sources/web_services/mongo_repository.dart';
import '../../data/models/show_data.dart';

import 'error_state.dart';

class PlayRepository {
  String get id => AuthBloc.user.id;

  Future<Either<Failure, void>> setUserAvailable(int? state) async {
    try {
      MongoDatabase.instance.setUserAvailable(id, state);
      return const Right(null);
    } catch (_) {
      return const Left(Failure("Error happened while setting your state"));
    }
  }

  Future<Either<Failure, int?>> getUserAvailable() async {
    try {
      int? state = await MongoDatabase.instance.getUserAvailable(id);
      return Right(state);
    } catch (_) {
      return const Left(Failure("Error happened while getting your state"));
    }
  }

  Future<Either<Failure, ShowData<Ground>>> getAllGrounds(int end) async {
    try {
      List<Map<String, dynamic>?> groundData =
          await MongoDatabase.instance.getGrounds(0, end);
      ShowData<Ground> data =
          ShowData(groundData.map((e) => Ground.fromJson(e!)).toList());
      return Right(data);
    } catch (_, __) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }


  Future<Either<Failure, ShowData<Ground>>> getMoreGrounds(
      ShowData<Ground> old) async {
    try {
      old.getNext();
      List<Map<String, dynamic>?> storeData =
          await MongoDatabase.instance.getGrounds(old.start, old.end);
      List<Ground> grounds = storeData.map((e) => Ground.fromJson(e!)).toList();
      old.data.addAll(grounds);
      return Right(old);
    } catch (_) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }

}
