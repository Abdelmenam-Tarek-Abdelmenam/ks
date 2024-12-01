
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../../../domain_layer/repository_implementer/error_state.dart';

const _baseUrl = "http://192.168.30.201/KS_API";
const _userDirectory = "user";
const _signUpTarget = "signup";
const _logInTarget = "login";

class DioDatabase {
  var dio = Dio();

  Future<void> init() async {
    if (await Connectivity().isNotConnected()) return;
  }

  Future<Map<String, dynamic>> makeRequest(
      {required String directory,
      required String target,
      required Map<String, dynamic> data}) async {
    var response = await dio.request(
      '$_baseUrl/$directory/$target.php',
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return {};
    }

  }

  Future<void> addUser(Map<String, dynamic> userData) async {
    await _preCheck();
    makeRequest(
        directory: _userDirectory, target: _signUpTarget, data: userData);
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

    return {};
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
