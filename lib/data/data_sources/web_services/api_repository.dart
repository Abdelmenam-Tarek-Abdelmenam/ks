import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../../domain_layer/repository_implementer/error_state.dart';

const _baseUrl = "https://api.example.com";

class DioDatabase {
  final Dio _dio =Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds:5000),
      receiveTimeout: const Duration(milliseconds:5000),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Future<void> init() async {
    if (await Connectivity().isNotConnected()) return;
  }

  void makeRequest(String getDirectory) async {
    try {
      final response = await _dio.get(
        '/$getDirectory',
        );
      print(response.data);
    } catch (e) {
      print(e);
    }
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
