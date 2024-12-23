import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_projects/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:final_projects/data/data_sources/web_services/errormessage.dart';
import '../../../domain_layer/repository_implementer/error_state.dart';

const _baseUrl = "https://application.ks-sports.com";

class ApiCall {
  static ApiCall get instance => ApiCall();

  Future<dynamic> makeRequest(
      {required String directory,
      required String target,
      Map<String, String>? data,
        String? after,
      bool isGet = false}) async {
    print('$_baseUrl/$directory/$target.php${after??''}');
    print(data);

    var request = http.MultipartRequest(
        isGet ? 'GET' : 'POST', Uri.parse('$_baseUrl/$directory/$target.php${after??''}'));

    if (data != null) {
      request.fields.addAll(data);
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      print(data);
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

    dynamic data = await makeRequest(
        directory: _userDirectory, target: _logInTarget, data: userData);

    if (data[0] == "Error") {
      throw LoginErrors.fromCode(int.tryParse(data[1]) ?? 10);
    } else {
      return data['Data'];
    }
  }

  Future<Map<String, dynamic>> getUserData(String id) async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _userDirectory,
        target: _getProfileTarget,
        data: {"id_user": id},
        isGet: true);

    if (data[0] == "Error") {
      throw const Failure();
    } else {
      return data[1];
    }
  }

  Future<bool> editUserData(Map<String, String> userData) async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _userDirectory,
        target: _updateProfileTarget,
        data: userData);

    return data.containsKey('Success');
  }

  Future<List<dynamic>> getTournament() async {
    await _preCheck();

    List<dynamic> data = await makeRequest(
        directory: _tournamentDirectory,
        target: _getTournamentTarget,
        isGet: true);

    if (data[0] == "Error") {
      throw const Failure("حدث خطأ اثناء رفع البيانات");
    } else {
      return List<Map<String, dynamic>>.from(data);
    }
  }

  Future<Map<String, dynamic>> checkRegistered(String id) async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _tournamentDirectory,
        target: _checkTournamentTarget,
        data: {'id_champ': id, 'id_user': AuthBloc.user.id});

    if (data.containsKey('Success')) {
      return data['Data'];
    } else if (data['Error'] == 'No subscription found') {
      return {};
    } else {
      throw const Failure("حدث خطأ اثناء طلب البيانات");
    }
  }

  Future<bool> registerTournament(Map<String, String> userData) async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _tournamentDirectory,
        target: _registerTournamentTarget,
        data: userData);

    return data.containsKey('Success');
  }

  Future<List<Map<String, dynamic>>> getGrounds() async {
    await _preCheck();

    List<dynamic> data =
        await makeRequest(directory: _playDirectory, target: _getGroundsTarget);
    if (data[0] == "Error") {
      throw const Failure();
    } else {
      return List<Map<String, dynamic>>.from(data[1]);
    }
  }

  Future<bool> registerGround(Map<String, String> userData) async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _playDirectory, target: _checkGroundsTarget, data: userData);

    if (data.containsKey('Success')) {
      List<dynamic> data = await makeRequest(
          directory: _playDirectory,
          target: _registerGroundsTarget,
          data: userData);

      return data[0] == 'Success';
    } else {
      throw Failure(data['Error']);
    }
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _subDirectory, target: _getProductsTarget, isGet: true);

    if (data['Error'] == 'No subscriptions found') {
      return [];
    }
    return List<Map<String, dynamic>>.from(data['Data']);
  }

  Future<Map<String, dynamic>> getMyProducts() async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _subDirectory,
        target: _checkProductsTarget, after : "?id_user=${AuthBloc.user.id}",
        isGet: true);

    if (data['Error'] == 'No active subscription found') {
      return {};
    }
    return Map<String, dynamic>.from(data['Data']);
  }

  Future<Map<String, dynamic>> getSub() async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _subDirectory,
        target: _getAllTarget,
        data: {'id_user' : AuthBloc.user.id},
        isGet: true);

    if (data['Error'] == 'No active subscription found') {
      return {};
    }
    return Map<String, dynamic>.from(data['Data']);
  }

  Future<bool> registerProduct(Map<String, String> userData) async {
    await _preCheck();

    Map<String, dynamic> data = await makeRequest(
        directory: _subDirectory,
        target: _registerProductsTarget,
        data: userData);

    return data.containsKey('Success');
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
const _getProfileTarget = "check_profile";
const _updateProfileTarget = "user_profile";

const _tournamentDirectory = "championships";
const _getTournamentTarget = "view";
const _registerTournamentTarget = "user_champ";
const _checkTournamentTarget = "user_check";

const _playDirectory = "court";
const _getGroundsTarget = "list";
const _registerGroundsTarget = "reserve";
const _checkGroundsTarget = "check_av";

const _subDirectory = "subscriptions";
const _getProductsTarget = "sub";
const _checkProductsTarget = "check_sub";
const _registerProductsTarget = "add";
const _getAllTarget = "get_all";

