import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';

class DiscoverApi {
  final DioClient dioClient = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getMoviesFromApi() async {
    try {
      final Response response =
          await dioClient.get('https://api.themoviedb.org/3/discover/movie');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getMovieDetailFromApi(
      {required String movieId}) async {
    try {
      final Response response =
          await dioClient.get(Endpoints.movieDetails + movieId);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
