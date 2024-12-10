
class SignUpErrors implements Exception {
  const SignUpErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpErrors.fromCode(int errorMessage) {
    switch (errorMessage) {
      case 5:
        return const SignUpErrors('البريد الالكتروني مستخدم من قبل');
      case 1:
        return const SignUpErrors('اسم المستخدم مفقود');
      case 2:
        return const SignUpErrors('البريد الالكتروني مفقود');
      case 3:
        return const SignUpErrors( 'كلمه المرور مفقوده');
      case 4:
        return const SignUpErrors('البريد الالكتروني غير صالح');
      case 6:
        return const SignUpErrors('خطا غير معروف اثناء التسجيل');
      case 7:
        return const SignUpErrors("لا يوجد بيانات ");
      default:
        return const SignUpErrors("خطا غير معروف اثناء التسجيل");
    }
  }

  final String message;
}

class LoginErrors implements Exception {
  const LoginErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LoginErrors.fromCode(int errorMessage) {

    switch (errorMessage) {
      case 1:
        return const LoginErrors('البريد الالكتروني مفقود');
      case 2:
        return const LoginErrors('كلمه المرور مفقوده');
      case 3:
        return const LoginErrors('كلمه المرور غير صحيحه');
      case 4:
        return const LoginErrors('البريد الالكتروني غير صحيحه');
      case 5:
        return const LoginErrors("لا يوجد بيانات ");
      default:
        return const LoginErrors("خطا غير معروف اثناء التسجيل");
    }
  }

  final String message;
}
