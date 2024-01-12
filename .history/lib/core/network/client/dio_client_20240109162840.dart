import 'package:dio/dio.dart';

import '../endpoints/endpoints.dart';
import '../interceptor/dio_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Y2YzMTFjOTE1MDNhMDBhNmJlZTUwMzFmMzMzMDZkZCIsInN1YiI6IjY1OWQwNGFkYzhhNWFjMDBlZDcxM2FiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zjMyX5-r09x1p5i7_kxGBZXyEsena3cJHZBCA0ibLQ4'
      }
      ..interceptors.add(DioInterceptor())
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
