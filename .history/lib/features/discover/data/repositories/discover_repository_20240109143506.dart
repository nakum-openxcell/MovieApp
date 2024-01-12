import 'package:moviedb_demo/features/home/data/models/discover_movie_model.dart';
import 'package:moviedb_demo/main.dart';

import '../api/discover_api.dart';

class DiscoverRepository {
  final DiscoverApi discoverApi;

  DiscoverRepository({required this.discoverApi});

  Future<DiscoverMovieModel> fetchMoviesRequested() async {
    try {
      final rawData = await discoverApi.getMoviesFromApi();
      return DiscoverMovieModel.fromJson(rawData);
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }
}
