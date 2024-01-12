import 'package:dio/dio.dart';

class DiscoverApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  HomeApi(this._dioClient);

  Future<Map<String, dynamic>> getMoviesFromApi() async {
    try {
      final Response response = await _dioClient.get('');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
