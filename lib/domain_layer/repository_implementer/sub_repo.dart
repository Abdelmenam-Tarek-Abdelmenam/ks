import 'package:either_dart/either.dart';

import '../../data/data_sources/web_services/api_repository.dart';
import 'error_state.dart';

class SubRepository {
  Future<Either<Failure, SubData>> getAllSubs() async {
    try {
      Map<String, dynamic> rowData = await ApiCall.instance.getSub();

      SubData data = SubData.fromJson(rowData);
      return Right(data);
    } on Failure catch (err) {
      return Left(err);
    } catch (_, __) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }
}


class SubData{
  final List<String> champ;
  final List<String> talents;

  SubData(this.champ,this.talents);

  factory SubData.fromJson(Map<String, dynamic>? data) => SubData([] , []);
  factory SubData.empty() =>  SubData([] , []);
}