import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../domain_layer/repository_implementer/error_state.dart';


class MongoDatabase {
  static MongoDatabase? _instance;
  static MongoDatabase get instance => _instance ??= MongoDatabase();

  Future<void> init() async {
    if (await Connectivity().isNotConnected()) return;

  }

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _preCheck();

  }

  Future<Map<String, dynamic>?> getUser(String id) async {
    await _preCheck();

    return {};
  }

  Future<void> setUserAvailable(String id, int? state) async {
    await _preCheck();

  }

  Future<int?> getUserAvailable(String id) async {
    await _preCheck();


    return 1;
  }

  Future<Map<String, dynamic>?> getUserAvailability(String id) async {
    await _preCheck();

    return{};
  }

  Future<List<Map<String, dynamic>?>> getRankedUser() async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getProduct(int start, int end) async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getOffers() async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getTournaments(int start, int end) async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getGrounds(int start, int end) async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getActiveMatches(
      int start, int end) async {
    await _preCheck();

    return [{}];
  }

  Future<List<Map<String, dynamic>?>> getCoaches(int start, int end) async {
    await _preCheck();

    return [{}];

  }

  Future<List<Map<String, dynamic>?>> getGyms(int start, int end) async {
    await _preCheck();

    return [{}];

  }

  Future<List<Map<String, dynamic>?>> getBenfits(
      int start, int end, String type) async {
    await _preCheck();

    return [{}];

  }

  Future<void> sendMessage(Map<String, dynamic> userData) async {
    await _preCheck();

  }

  Future<void> _preCheck() async {
    if (await Connectivity().isNotConnected()) {
      throw const Failure("No Internet connection");
    }

  }
}

extension Check on Connectivity {
  Future<bool> isNotConnected() async {
    var connectivityResult = await (checkConnectivity());
    return connectivityResult[0] == ConnectivityResult.none;
  }
}
