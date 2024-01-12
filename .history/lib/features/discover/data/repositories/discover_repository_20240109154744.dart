import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/main.dart';

import '../api/discover_api.dart';

class DiscoverRepository {
  DiscoverRepository();

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
