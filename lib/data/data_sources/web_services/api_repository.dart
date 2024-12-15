import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:final_projects/data/data_sources/web_services/errormessage.dart';
import '../../../domain_layer/repository_implementer/error_state.dart';

const _baseUrl = "https://application.ks-sports.com";

class ApiCall {
  static ApiCall get instance => ApiCall();

  Future<dynamic> makeRequest(
      {required String directory,
      required String target,
      Map<String, String>? data}) async {
    print('$_baseUrl/$directory/$target.php');
    print(data);

    var request = http.MultipartRequest(
        'POST', Uri.parse('$_baseUrl/$directory/$target.php'));
    if (data != null) {
      request.fields.addAll(data);
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      return json.decode(data);
    } else {
      throw Failure(response.reasonPhrase ?? "حدث خطأ اثناء الاتصال بالخادم");
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

  Future<Map<String, dynamic>> signIn(Map<String, String> userData) async {
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


  Future<Map<String, dynamic>> getUserData(String id) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _userDirectory, target: _getProfileTarget, data: {"userId" : id});

    if (data[0] == "Error") {
      throw const Failure();
    } else {
      return data[1];
    }
  }

  Future<bool> editUserData(Map<String, String> userData) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _userDirectory,
        target: _updateProfileTarget,
        data: userData);

    if (data[0] == "Error") {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getTournament() async {
    await _preCheck();

    List<Map<String, dynamic>> data = await makeRequest(
        directory: _tournamentDirectory, target: _getTournamentTarget);
    return data;
  }

  Future<bool> registerTournament(Map<String, String> userData) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _tournamentDirectory,
        target: _registerTournamentTarget,
        data: userData);

    if (data[0] == "Error") {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> getGrounds() async {
    await _preCheck();

    List<Map<String, dynamic>> data =
        await makeRequest(directory: _playDirectory, target: _getGroundsTarget);

    return data;
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    await _preCheck();

    List<Map<String, dynamic>> data =
        await makeRequest(directory: _playDirectory, target: _getProductsTarget);

    return data;
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

const _userDirectory = "user";
const _signUpTarget = "signup";
const _logInTarget = "login";
const _getProfileTarget = "profile";
const _updateProfileTarget = "update_profile";

const _tournamentDirectory = "user";
const _getTournamentTarget = "user";
const _registerTournamentTarget = "user";

const _playDirectory = "user";
const _getGroundsTarget = "user";
const _getProductsTarget = "user";
