import 'package:either_dart/either.dart';
import 'package:final_projects/data/data_sources/web_services/api_repository.dart';
import 'package:final_projects/data/models/product.dart';
import '../../data/models/matches.dart';

import 'error_state.dart';

class PlayRepository {
  Future<Either<Failure, List<Ground>>> getAllGrounds() async {
    try {
      List<Map<String, dynamic>> rowData = await ApiCall.instance.getGrounds();

      List<Ground> data = rowData.map((e) => Ground.fromJson(e)).toList();
      return Right(data);
    } on Failure catch (err) {
      return Left(err);
    } catch (_, __) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      List<Map<String, dynamic>> rowData = await ApiCall.instance.getProducts();

      List<Product> data = rowData.map((e) => Product.fromJson(e)).toList();
      return Right(data);
    } catch (_, __) {
      return const Left(Failure("Error happened while getting grounds"));
    }
  }
}
