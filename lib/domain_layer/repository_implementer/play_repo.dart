import 'package:either_dart/either.dart';
import '../../data/models/matches.dart';

import '../../data/models/show_data.dart';

import 'error_state.dart';

class PlayRepository {

  Future<Either<Failure, void>> setUserAvailable(int? state) async {
    try {
      return const Right(null);
    } catch (_) {
      return const Left(Failure("Error happened while setting your state"));
    }
  }

  Future<Either<Failure, int?>> getUserAvailable() async {
    try {
      return Right(0);
    } catch (_) {
      return const Left(Failure("Error happened while getting your state"));
    }
  }

  Future<Either<Failure, ShowData<Ground>>> getAllGrounds(int end) async {
    try {
      ShowData<Ground> data =
          ShowData([].map((e) => Ground.fromJson(e!)).toList());
      return Right(data);
    } catch (_, __) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }


  Future<Either<Failure, ShowData<Ground>>> getMoreGrounds(
      ShowData<Ground> old) async {
    try {
      old.getNext();

      List<Ground> grounds = [].map((e) => Ground.fromJson(e!)).toList();
      old.data.addAll(grounds);
      return Right(old);
    } catch (_) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }

}
