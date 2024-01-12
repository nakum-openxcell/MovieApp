import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/main.dart';

import '../api/discover_api.dart';

class DiscoverRepository {
  Future<DiscoverMovieModel> fetchMoviesRequested(
      {required int currentPage}) async {
    try {
      final rawData = await getIt
          .get<DiscoverApi>()
          .getMoviesFromApi(currentPage: currentPage);
      final model = DiscoverMovieModel.fromJson(rawData);
      return model;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<MovieDetailsModel> movieDetailsRequested(
      {required String movieId}) async {
    try {
      final rawData = await getIt
          .get<DiscoverApi>()
          .getMovieDetailFromApi(movieId: movieId);
      return MovieDetailsModel.fromJson(rawData);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<DiscoverMovieModel> searchMoviesRequested(
      {required String query}) async {
    try {
      final rawData =
          await getIt.get<DiscoverApi>().searchMoviesFromApi(query: query);
      return DiscoverMovieModel.fromJson(rawData);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<MovieDetailsModel> recommendedMoviesRequested(
      {required String movieId}) async {
    try {
      final rawData = await getIt
          .get<DiscoverApi>()
          .getRecommendedMoviesFromApi(movieId: movieId);
      return MovieDetailsModel.fromJson(rawData);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
