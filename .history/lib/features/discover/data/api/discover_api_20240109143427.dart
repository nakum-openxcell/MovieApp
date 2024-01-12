import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';

class DiscoverApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  DiscoverApi(this._dioClient);

  Future<Map<String, dynamic>> getMoviesFromApi() async {
    try {
      final Response response = await _dioClient.get('');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
