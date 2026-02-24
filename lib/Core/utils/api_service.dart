// هنعمل هنا ال wrapper اللي بيحتفظ بكل المعلومات و بيهندل كل حاجة بتتعلق بال api call بتاعتي زي ال get request و ال post request و ال put request و ال delete request و اي حاجة انا محتاجها في ال api call بتاعتي زي ال headers و ال query parameters و غيرها كتير من الحاجات اللي بتسهل عليا التعامل مع ال api call بتاعتي
import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get('$_baseUrl$endpoint');
    return response.data;
  }
}
