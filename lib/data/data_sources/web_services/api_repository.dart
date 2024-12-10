import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:final_projects/data/data_sources/web_services/errormessage.dart';
import '../../../domain_layer/repository_implementer/error_state.dart';

const _baseUrl = "https://application.ks-sports.com";
const _userDirectory = "user";
const _signUpTarget = "signup";
const _logInTarget = "login";

class ApiCall {
  Future<void> init() async {
    if (await Connectivity().isNotConnected()) return;
  }

  Future<dynamic> makeRequest(
      {required String directory,
      required String target,
      required Map<String, String> data}) async {
    print('$_baseUrl/$directory/$target.php');
    print(data);

    var request = http.MultipartRequest(
        'POST', Uri.parse('$_baseUrl/$directory/$target.php'));
    request.fields.addAll(data);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      return json.decode(data);
    } else {
      throw Failure(response.reasonPhrase?? "حدث خطأ اثناء الاتصال بالخادم");
    }
  }

  Future<bool> signUp(Map<String, String> userData) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _userDirectory, target: _signUpTarget, data: userData);

    if (data[0] == "Error") {
      throw SignUpErrors.fromCode(int.tryParse(data[1]) ?? 10);
    } else {
      return true;
    }
  }
  
  Future<Map<String,dynamic>> signIn(Map<String, String> userData) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _userDirectory, target: _logInTarget, data: userData);

    if (data[0] == "Error") {
      throw LoginErrors.fromCode(int.tryParse(data[1]) ?? 10);
    } else {
      print(data[1]);
      return data[1];
    }
  }

  /////////////////////////////////////////////

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
      throw const Failure("لا يوجد اتصال بالشبكه");
    }
  }
}

extension Check on Connectivity {
  Future<bool> isNotConnected() async {
    var connectivityResult = await (checkConnectivity());
    return connectivityResult[0] == ConnectivityResult.none;
  }
}
