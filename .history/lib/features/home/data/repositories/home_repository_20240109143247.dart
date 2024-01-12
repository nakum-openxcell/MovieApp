import 'dart:async';
import 'dart:developer';

import '../api/home_api.dart';
import '../models/discover_movie_model.dart';

class HomeRepository {
  final HomeApi homeApi;

  HomeRepository({required this.homeApi});

  Future<DiscoverMovieModel> fetchMoviesRequested() async {
    try {
      final rawData = await homeApi.getMoviesFromApi();
      return DiscoverMovieModel.fromJson(rawData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
