import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';

class DiscoverApi {
  final DioClient dioClient = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getMoviesFromApi(
      {required int currentPage}) async {
    try {
      final Response response = await dioClient
          .get(Endpoints.discover, queryParameters: {"page": currentPage});
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

  Future<Map<String, dynamic>> searchMoviesFromApi(
      {required String query}) async {
    try {
      final Response response =
          await dioClient.get('${Endpoints.searchMovie}?query=$query');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getRecommendedMoviesFromApi(
      {required String movieId}) async {
    try {
      final Response response = await dioClient
          .get('${Endpoints.searchMovie}/movie_id=$movieId/recommendations');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
