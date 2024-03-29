import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/data/repositories/discover_repository.dart';
import 'package:moviedb_demo/features/discover/local/db/app_db.dart';
import 'package:moviedb_demo/utils/connection/connection.dart';

part 'discover_store.g.dart';

class DiscoverStore = _DiscoverStore with _$DiscoverStore;

abstract class _DiscoverStore with Store {
  final DiscoverRepository _discoverRepository =
      getIt.get<DiscoverRepository>();

  int currentPage = 1;
  AppDb appDb = getIt.get<AppDb>();

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingMoreMovies = false;

  @observable
  bool isGridViewEnabled = false;

  @observable
  bool isSearchEnabled = false;

  @observable
  DiscoverMovieModel discoverMovieModel = DiscoverMovieModel();

  @observable
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();

  @action
  Future<void> fetchMoviesRequested() async {
    if (await ConnectionUtils.isNetworkConnected()) {
      await appDb.clearDb();
      isLoading = true;
      try {
        final data = await _discoverRepository.fetchMoviesRequested(
          currentPage: currentPage,
        );
        discoverMovieModel = data;
        await insertInDb();
        isLoading = false;
      } on DioError catch (e) {
        discoverMovieModel =
            DiscoverMovieModel(error: e.response?.data['status_message']);
        isLoading = false;
      }
    } else {
      final storedMovies = await appDb.getMovies();
      discoverMovieModel = DiscoverMovieModel(
        results: storedMovies
            .map((e) => Results(
                title: e.title,
                backdropPath: e.backdropPath,
                overview: e.overview,
                voteAverage: e.voteAverage,
                id: e.id))
            .toList(),
      );
    }
  }

  Future<void> insertInDb() async {
    if (discoverMovieModel.results != null) {
      final movieList = discoverMovieModel.results!
          .map((e) => MovieCompanion(
                id: Value(e.id ?? 0),
                title: Value(e.title ?? ''),
                backdropPath: Value(e.backdropPath ?? ''),
                overview: Value(e.overview ?? ''),
                voteAverage: Value(((e.voteAverage ?? 0.0) as num).toDouble()),
              ))
          .toList();
      await appDb.insertMovies(movieList);
    }
  }

  @action
  Future fetchMoviesDetails({required String movieId}) async {
    isLoading = true;
    try {
      final data =
          await _discoverRepository.movieDetailsRequested(movieId: movieId);
      movieDetailsModel = data;
      isLoading = false;
    } on DioError catch (e) {
      movieDetailsModel =
          MovieDetailsModel(error: e.response?.data['status_message']);
      isLoading = false;
    }
  }

  @action
  Future searchMovies({required String query}) async {
    if (query.isEmpty) {
      await fetchMoviesRequested();
    } else {
      isLoading = true;
      discoverMovieModel =
          await _discoverRepository.searchMoviesRequested(query: query);
      isLoading = false;
    }
  }

  @action
  void updateLayout() {
    isGridViewEnabled = !isGridViewEnabled;
  }

  @action
  void updateSearch() {
    isSearchEnabled = !isSearchEnabled;
  }
}
