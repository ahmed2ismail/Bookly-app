// هنا انا بعمل class اسمه Failure في ال core layer وبعمله subclasses بترثه ومخصصة لكل نوع من ال failure اللي ممكن يحصل في ال api response بتاعتي زي network failure او server failure او cache failure
// ال class دا هستخدمه في ال repository بتاعي عشان احدد ال return type بتاع ال method اللي بتتعامل مع ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// هحدد ال errors اللي هتظهرلي في التطبيق في المستقبل فلما ي المستقبل يحصل error في ال api response هحدد ال errors هنا ك subclasses
import 'package:dio/dio.dart';

// الكلاس الأساسي (الأب) لكل أنواع الأخطاء في التطبيق
abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

// ---------------------------------------------------------
// 1. أخطاء السيرفر (Server Failures)
// ---------------------------------------------------------
class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  // مصنع بيحول أخطاء Dio لرسائل واضحة
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          'Connection timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          'Send timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          'Receive timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          'SSL certificate error. Please check your connection security.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError
              .response!
              .statusCode!, // هرجع كود الحالة عشان نقدر نحدد نوع الخطأ
          dioError
              .response!
              .data, // هرجع البيانات عشان نقدر نطلع رسالة الخطأ المناسبة من السيرفر لو موجودة
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection.');
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection.');
        }
        return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  // دالة تحليل أكواد الـ HTTP اللي راجعة من السيرفر
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      try {
        return ServerFailure(
          response['error']['message'] ?? 'Authentication or data error.',
        );
      } catch (e) {
        return ServerFailure(
          'Authentication or data error. Please check your input.',
        );
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 429) {
      // إضافة خطأ الـ Quota اللي بيظهر في حال تخطيت ال limit لل api
      return ServerFailure(
        'Too many requests. Your API quota is exhausted. Please try again tomorrow.',
      );
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again later');
    }
  }
}

// ---------------------------------------------------------
// 2. أخطاء التخزين المحلي (Cache Failures)
// لما تستخدم Hive عشان تحفظ الكتب وتفتحها بدون إنترنت
// ---------------------------------------------------------
class CacheFailure extends Failure {
  CacheFailure(super.errMessage);
}