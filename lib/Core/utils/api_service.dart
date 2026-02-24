// هنعمل هنا ال wrapper اللي بيحتفظ بكل المعلومات و بيهندل كل حاجة بتتعلق بال api call بتاعتي زي ال get request و ال post request و ال put request و ال delete request و اي حاجة انا محتاجها في ال api call بتاعتي زي ال headers و ال query parameters و غيرها كتير من الحاجات اللي بتسهل عليا التعامل مع ال api call بتاعتي
import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiService(this._dio);

// احنا هنا حاطين ال get request بتاعنا بس عشان احنا لسه ما احتجناش غير ال get request في ال api call بتاعتنا لل features دول featured books و best seller books بس في المستقبل ممكن نحتاج اي نوع تاني من ال requests زي ال post request او ال put request او ال delete request فانا هضيفهم هنا لما احتاجهم في المستقبل
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get('$_baseUrl$endpoint');
    return response.data;
  }
}
