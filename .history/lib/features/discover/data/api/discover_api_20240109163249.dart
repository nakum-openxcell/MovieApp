import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';
import 'package:moviedb_demo/di/service_locator.dart';

class DiscoverApi {
  final DioClient dioClient = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getMoviesFromApi() async {
    try {
      final Response response =
          await dioClient.get('https://fakestoreapi.com/products/1');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}