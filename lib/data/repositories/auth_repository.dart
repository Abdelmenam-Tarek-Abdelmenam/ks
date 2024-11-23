
import '../data_sources/pref_repository.dart';
import '../models/app_user.dart';

class AuthRepository {



  Future<AppUser> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
          return AppUser.empty();
    } catch (e) {
      throw const FireBaseAuthErrors();
    }
  }

  Future<AppUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
          return AppUser.empty();
    } catch (e) {
      throw const FireBaseAuthErrors();
    }
  }

  Future<AppUser> signInUsingGoogle() async {
    try {
          return AppUser.empty();
    } catch (e) {
      throw const FireBaseAuthErrors();
    }
  }

  static Future<void> signOut() async {
    PreferenceRepository.clearAll();
  }

  Future<void> forgetPassword(String email) async {
    try {
    } catch (_) {
      throw const FireBaseAuthErrors();
    }
  }
}

class FireBaseAuthErrors implements Exception {
  final String message;

  const FireBaseAuthErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory FireBaseAuthErrors.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const FireBaseAuthErrors(
          'Email is not valid or badly formatted.',
        );
      case 'Email not verified':
        return const FireBaseAuthErrors(
          'Email is not verified. please check it.',
        );
      case 'user-disabled':
        return const FireBaseAuthErrors(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const FireBaseAuthErrors(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const FireBaseAuthErrors(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const FireBaseAuthErrors(
          'Please enter a stronger password.',
        );
      case 'user-not-found':
        return const FireBaseAuthErrors(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const FireBaseAuthErrors(
          'Incorrect password, please try again.',
        );
      case 'account-exists-with-different-credential':
        return const FireBaseAuthErrors(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const FireBaseAuthErrors(
          'The credential received is malformed or has expired.',
        );
      case 'invalid-verification-code':
        return const FireBaseAuthErrors(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const FireBaseAuthErrors(
          'The credential verification ID received is invalid.',
        );
      default:
        return const FireBaseAuthErrors();
    }
  }
}
