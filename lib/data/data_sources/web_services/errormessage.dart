class SignUpErrors implements Exception {
  const SignUpErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpErrors.fromCode(int errorMessage) {
    String message;
    switch (errorMessage) {
      case 5:
        message = 'البريد الالكتروني مستخدم من قبل';
        break;
      case 1:
        message = 'اسم المستخدم مفقود';
        break;
      case 2:
        message = 'البريد الالكتروني مفقود';
        break;
      case 3:
        message = 'كلمه المرور مفقوده';
        break;
      case 4:
        message = 'البريد الالكتروني غير صالح';
        break;
      case 6:
        message = 'خطا غير معروف اثناء التسجيل';
        break;
      case 7:
        message = "لا يوجد بيانات ";
        break;
      default:
        message = "خطا غير معروف اثناء التسجيل";
        break;
    }
    return SignUpErrors(message);
  }

  final String message;
}

class LoginUpErrors implements Exception {
  const LoginUpErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LoginUpErrors.fromCode(int errorMessage) {
    String message;
    switch (errorMessage) {
      case 1:
        message = 'البريد الالكتروني مفقود';
        break;
      case 2:
        message = 'كلمه المرور مفقوده';
      case 3:
        message = 'كلمه المرور غير صحيحه';
        break;
      case 4:
        message = 'البريد الالكتروني غير صحيحه';
        break;
      case 5:
        message = "لا يوجد بيانات ";
        break;
      default:
        message = "خطا غير معروف اثناء التسجيل";
        break;
    }
    return LoginUpErrors(message);
  }

  final String message;
}
