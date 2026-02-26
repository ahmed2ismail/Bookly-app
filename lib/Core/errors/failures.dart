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
        return ServerFailure(response['error']['message']);
      } catch (e) {
        return ServerFailure(
          'Authentication or data error. Please check your input.',
        );
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}

// ---------------------------------------------------------
// 2. أخطاء التخزين المحلي (Cache Failures)
// هتحتاجها لما تستخدم Hive عشان تحفظ الكتب وتفتحها بدون إنترنت
// ---------------------------------------------------------
class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);

  // هنعمل مصنع لتحويل أخطاء التخزين المحلي لرسائل واضحة
  factory CacheFailure.fromDioError(DioException dioError) {
    // هنا ممكن تحلل أخطاء التخزين المحلي لو حبيت تضيفها في المستقبل
    if (dioError.type == DioExceptionType.connectionTimeout) {
      return CacheFailure(
        'Connection timeout with Cache Server. Please try again later.',
      );
    } else if (dioError.type == DioExceptionType.sendTimeout) {
      return CacheFailure(
        'Send timeout with Cache Server. Please try again later.',
      );
    } else if (dioError.type == DioExceptionType.receiveTimeout) {
      return CacheFailure(
        'Receive timeout with Cache Server. Please try again later.',
      );
    } else if (dioError.type == DioExceptionType.cancel) {
      return CacheFailure('Request to Cache Server was canceled.');
    } else if (dioError.type == DioExceptionType.connectionError) {
      return CacheFailure('No Connection to Cache Server.');
    } else if (dioError.type == DioExceptionType.unknown &&
        dioError.message != null &&
        dioError.message!.contains('HiveError')) {
      return CacheFailure('Cache storage error. Please try again later.');
    } else if (dioError.type == DioExceptionType.badResponse &&
        dioError.response != null &&
        dioError.response!.statusCode == 404) {
      return CacheFailure.fromResponse(
        dioError.response!.statusCode!,
        dioError.response!.data,
      );
    } else {
      return CacheFailure('Unexpected Error, Please try again!');
    }
  }

  // ممكن تضيف مصنع لتحليل أخطاء Hive لو حبيتها
  factory CacheFailure.fromResponse(int statusCode, dynamic response) {
    // هنا ممكن تحلل أخطاء Hive لو حبيت تضيفها في المستقبل
    if (statusCode == 404) {
      return CacheFailure('No cached data found.');
    } else if (statusCode == 500) {
      return CacheFailure('Cache storage error. Please try again later.');
    } else {
      return CacheFailure('Opps There was an Error, Please try again');
    }
  }
}

// ---------------------------------------------------------
// 3. أخطاء الشبكة العامة (Network Failures)
// لو مثلاً عايز تطلع إيرور لو مفيش نت حتى قبل ما تبعت طلب للـ API
// ---------------------------------------------------------
class NetworkFailure extends Failure {
  NetworkFailure(super.errorMessage);

  // هنعمل مصنع لتحليل أخطاء الشبكة لو حبيتها
  factory NetworkFailure.fromDioError(DioException dioError) {
    // هنا ممكن تحلل أخطاء الشبكة لو حبيت تضيفها في المستقبل
    if (dioError.type == DioExceptionType.connectionTimeout) {
      return NetworkFailure(
        'Connection timeout. Please check your internet connection and try again.',
      );
    } else if (dioError.type == DioExceptionType.connectionError) {
      return NetworkFailure('No Internet Connection. Please try again later.');
    } else if (dioError.type == DioExceptionType.cancel) {
      return NetworkFailure('Network request was canceled. Please try again.');
    } else if (dioError.type == DioExceptionType.unknown &&
        dioError.message != null &&
        dioError.message!.contains('SocketException')) {
      return NetworkFailure('No Internet Connection. Please try again later.');
    } else {
      return NetworkFailure('Unexpected Network Error, Please try again!');
    }
  }

  // ممكن تضيف مصنع لتحليل أخطاء الشبكة لو حبيتها
  factory NetworkFailure.fromResponse(int statusCode, dynamic response) {
    // هنا ممكن تحلل أخطاء الشبكة لو حبيت تضيفها في المستقبل
    if (statusCode == 404) {
      return NetworkFailure('No network connection found.');
    } else if (statusCode == 500) {
      return NetworkFailure('Network error. Please try again later.');
    } else {
      return NetworkFailure('Opps There was an Error, Please try again');
    }
  }
}

// ---------------------------------------------------------
// 4. أخطاء المنطق البرمجي (Logic Failures)
// بتستخدمها لو حصل خطأ في الـ Code نفسه أو عملية معالجة بيانات فشلت
// ---------------------------------------------------------
class LogicFailure extends Failure {
  LogicFailure(super.errorMessage);

  // هنعمل مصنع لتحليل أخطاء المنطق لو حبيتها
  factory LogicFailure.fromDioError(DioException dioError) {
    // هنا ممكن تحلل أخطاء المنطق لو حبيت تضيفها في المستقبل
    if (dioError.type == DioExceptionType.unknown) {
      return LogicFailure('Unexpected logic error occurred. Please try again.');
    } else {
      return LogicFailure('Opps There was an Error, Please try again');
    }
  }

  // ممكن تضيف مصنع لتحليل أخطاء المنطق لو حبيتها
  factory LogicFailure.fromResponse(int statusCode, dynamic response) {
    // هنا ممكن تحلل أخطاء المنطق لو حبيت تضيفها في المستقبل
    if (statusCode == 400) {
      return LogicFailure('Invalid data format. Please check your input.');
    } else if (statusCode == 500) {
      return LogicFailure(
        'Unexpected processing error. Please try again later.',
      );
    } else {
      return LogicFailure('Opps There was an Error, Please try again');
    }
  }
}

// ---------------------------------------------------------
// 5. حالات البيانات الفارغة (Empty State Failures)
// الساعات الـ API بيرد بـ 200 (نجاح) بس القائمة بتكون فاضية
// ---------------------------------------------------------

// لو طلبت كتب من السيرفر ورجع القائمة فاضية
class EmptyServerFailure extends Failure {
  EmptyServerFailure(super.errorMessage);

  // هنعمل مصنع لتحليل حالة البيانات الفارغة من السيرفر
  factory EmptyServerFailure.fromDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.badResponse &&
        dioError.response != null &&
        dioError.response!.statusCode == 200) {
      return EmptyServerFailure('No books found. Please try again later.');
    } else {
      return EmptyServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory EmptyServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 200) {
      return EmptyServerFailure('No books found. Please try again later.');
    } else {
      return EmptyServerFailure('Opps There was an Error, Please try again');
    }
  }
}

// لو دورت في الكاش (Hive) وملقتش بيانات محفوظة
class EmptyCacheFailure extends Failure {
  EmptyCacheFailure(super.errorMessage);

  // هنعمل مصنع لتحليل حالة البيانات الفارغة من الكاش
  factory EmptyCacheFailure.fromDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.badResponse &&
        dioError.response != null &&
        dioError.response!.statusCode == 200) {
      return EmptyCacheFailure(
        'No cached books found. Please try again later.',
      );
    } else {
      return EmptyCacheFailure('Opps There was an Error, Please try again');
    }
  }

  factory EmptyCacheFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 200) {
      return EmptyCacheFailure(
        'No cached books found. Please try again later.',
      );
    } else {
      return EmptyCacheFailure('Opps There was an Error, Please try again');
    }
  }
}

// لو مفيش بيانات شبكة متوفرة حالياً
class EmptyNetworkFailure extends Failure {
  EmptyNetworkFailure(super.errorMessage);

  // هنعمل مصنع لتحليل حالة البيانات الفارغة من الشبكة
  factory EmptyNetworkFailure.fromDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.badResponse &&
        dioError.response != null &&
        dioError.response!.statusCode == 200) {
      return EmptyNetworkFailure(
        'No network data found. Please try again later.',
      );
    } else if (dioError.type == DioExceptionType.connectionError) {
      return EmptyNetworkFailure(
        'No Internet Connection. Please try again later.',
      );
    } else {
      return EmptyNetworkFailure('Opps There was an Error, Please try again');
    }
  }

  factory EmptyNetworkFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 200) {
      return EmptyNetworkFailure(
        'No network data found. Please try again later.',
      );
    } else {
      return EmptyNetworkFailure('Opps There was an Error, Please try again');
    }
  }
}
