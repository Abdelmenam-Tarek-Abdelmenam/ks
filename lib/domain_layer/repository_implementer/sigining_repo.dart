import 'package:either_dart/either.dart';
import 'package:final_projects/data/data_sources/pref_repository.dart';
import 'package:final_projects/data/data_sources/web_services/api_repository.dart';
import 'package:final_projects/data/data_sources/web_services/errormessage.dart';
import '../../data/models/app_user.dart';
import 'error_state.dart';

class SigningRepository {
  final ApiCall _api = ApiCall.instance;

  Future<Either<Failure, AppUser>> signUpWithEmailAndPassword(
      DefaultUser tempUser, String pass) async {
    if (tempUser.noUser || pass.isEmpty) {
      return const Left(Failure("لا يمكنك ترك المعلومات فارغه"));
    }

    try {
      bool success = await _api.signUp(tempUser.loginJson(pass));
      if (success) {
        Map<String, dynamic> userData =
            await _api.signIn(tempUser.loginJson(pass));
        AppUser user = AppUser.fromJson(userData, email: tempUser.email);
        PreferenceRepository.putData(
            value: user.toJson, key: PreferenceKey.userData);
        return Right(user);
      } else {
        return const Left(Failure("حدث خطأ اثناء طلب المعلومات"));
      }
    } on SignUpErrors catch (e) {
      return Left(Failure.fromError(e));
    } catch (_,__) {
      return const Left(Failure("حدث خطأ اثناء طلب المعلومات"));
    }
  }

  Future<Either<Failure, AppUser>> signInWithEmailAndPassword(
      String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      return const Left(Failure("لا يمكنك ترك المعلومات فارغه"));
    }

    try {
      DefaultUser temp = DefaultUser(email: email, name: '');
      Map<String, dynamic> userData = await _api.signIn(temp.loginJson(pass));
      AppUser user = AppUser.fromJson(userData, email: email);
      PreferenceRepository.putData(
          value: user.toJson, key: PreferenceKey.userData);
      return Right(user);
    } on LoginErrors catch (e) {
      return Left(Failure.fromError(e));
    } catch (_, __) {
      print(_);
      print(__);
      return const Left(Failure("حدث خطأ اثناء طلب المعلومات"));
    }
  }

  Future<Either<Failure, void>> editUser(Map<String, String> data) async {
    try {
      bool ret = await _api.editUserData(data);
      if (ret) {
        return const Right(null);
      } else {
        return const Left(Failure("حدث خطأ اثناء تسجيل المعلومات"));
      }
    } on LoginErrors catch (e) {
      return Left(Failure.fromError(e));
    } catch (_) {
      return const Left(Failure("حدث خطأ اثناء طلب المعلومات"));
    }
  }
}
