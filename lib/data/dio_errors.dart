import 'package:dio/dio.dart';

class DioErrors implements Exception {
  const DioErrors([
    this.message = 'An unknown exception occurred.',
  ]);

  factory DioErrors.fromCode(DioExceptionType error) {
    String message;
    switch (error) {
      case DioExceptionType.connectionTimeout:
        message = 'server not reachable';
        break;
      case DioExceptionType.sendTimeout:
        message = 'send Time out';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'server not reachable';
        break;
      case DioExceptionType.badResponse:
        message = 'the server response, but with a incorrect status';
        break;
      case DioExceptionType.cancel:
        message = 'request is cancelled';
        break;
      default :
        message = "Unknown error happened";
        break;
    }
    return DioErrors(message);
  }

  final String message;
}
