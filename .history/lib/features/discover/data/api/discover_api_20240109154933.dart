import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';

class DiscoverApi {
  Future<Map<String, dynamic>> getMoviesFromApi() async {
    try {
      final Response response = await _dioClient.get('');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
