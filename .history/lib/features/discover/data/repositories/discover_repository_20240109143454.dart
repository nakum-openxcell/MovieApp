import '../api/discover_api.dart';

class DiscoverRepository {
  final DiscoverApi discoverApi;

  DiscoverRepository({required this.discoverApi});

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
