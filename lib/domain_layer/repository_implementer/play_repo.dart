import 'dart:ffi';

import 'package:either_dart/either.dart';
import 'package:final_projects/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:final_projects/data/data_sources/web_services/api_repository.dart';
import 'package:final_projects/data/models/product.dart';
import 'package:final_projects/domain_layer/date_extensions.dart';
import '../../data/models/matches.dart';

import 'error_state.dart';

class PlayRepository {
  Future<Either<Failure, List<Ground>>> getAllGrounds() async {
    try {
      print("Here");
      List<Map<String, dynamic>> rowData = await ApiCall.instance.getGrounds();
      print(rowData);

      List<Ground> data = rowData.map((e) => Ground.fromJson(e)).toList();
      return Right(data);
    } on Failure catch (err) {
      return Left(err);
    } catch (_, __) {
      print(_);
      print(__);
      return const Left(Failure("Error happened while getting grounds"));
    }
  }

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      List<Map<String, dynamic>> rowData = await ApiCall.instance.getProducts();

      List<Product> data = rowData.map((e) => Product.fromJson(e)).toList();
      return Right(data);
    } catch (_, __) {
      print(_);
      print(__);
      return const Left(Failure("Error happened while getting grounds"));
    }
  }

  Future<Either<Failure, void>> registerGround(GroundRegister data) async {
    try {
      bool rowData = await ApiCall.instance.registerGround(data.toJson);
      if (rowData) {
        return const Right(null);
      } else {
        throw const Failure();
      }
    } on Failure catch (err) {
      return Left(err);
    } catch (_, __) {
      print(_);
      print(__);
      return const Left(Failure("حدث خطأ اثناء التسجيل"));
    }
  }

  Future<Either<Failure, void>> registerProduct(ProductRegister data) async {
    try {
      bool rowData = await ApiCall.instance.registerProduct(data.toJson);
      if (rowData) {
        return const Right(null);
      } else {
        throw const Failure();
      }
    } on Failure catch (err) {
      return Left(err);
    } catch (_, __) {
      return const Left(Failure("حدث خطأ اثناء التسجيل"));
    }
  }
}

class GroundRegister {
  final String idCourt;
  final String dateRsvCourt; // Expected format: YYYY-MM-DD
  final String startRsvCourt; // Expected format: HH:MM:SS
  final String endRsvCourt; // Expected format: HH:MM:SS

  GroundRegister({
    required this.idCourt,
    required this.dateRsvCourt,
    required this.startRsvCourt,
    required this.endRsvCourt,
  });

  // Convert class instance to JSON
  Map<String, String> get toJson {

    return {
      'id_user': AuthBloc.user.id,
      'id_court': idCourt,
      'date_rsv_court': dateRsvCourt,
      'start_rsv_court':
         startRsvCourt,
      'end_rsv_court':
          endRsvCourt,
    };
  }
}

class ProductRegister {
  final String idSub;

  ProductRegister({
    required this.idSub,
  });

  // Convert class instance to JSON
  Map<String, String> get toJson {

    return {
      'id_user': AuthBloc.user.id,
      'id_sub': idSub,
      'start_date': DateTime.now().formatDate,
      'end_date': '',
    };
  }
}
