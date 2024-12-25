import 'package:either_dart/either.dart';
import 'package:final_projects/data/models/tournament.dart';

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

class SubData {
  final List<Tournament> champ;
  final List<Subscription> talents;

  SubData(this.champ, this.talents);

  factory SubData.fromJson(Map<String, dynamic> data) {
    List<dynamic> champTemp = data['champ']??[];
    List<dynamic> talentsTemp = data['sub']??[];

    return SubData(champTemp.map((e) => Tournament.fromJson(e)).toList(),talentsTemp.map((e) => Subscription.fromJson(e)).toList());
  }

  factory SubData.empty() => SubData([], []);
}

class Subscription {
  String endDate;
  String name;
  String price;
  String sessionsNum;

  Subscription({
    required this.name,
    required this.endDate,
    required this.price,
    required this.sessionsNum,
  });

  factory Subscription.fromJson(Map<String, dynamic> data) => Subscription(
      name: data['name_sub'], endDate: data['end_date'], price:  " سعر الاشتراك ${data["price_sub"].toString()}", sessionsNum: data['num_session'].toString());
}
