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
  DiscoverMovieModel recommendedMovieModel = DiscoverMovieModel();

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
      fetchMoviesFromDb();
    }
  }

  @action
  Future<void> nextPage() async {
    if (await ConnectionUtils.isNetworkConnected()) {
      currentPage++;
      final prevResults = discoverMovieModel.results;
      await _discoverRepository
          .fetchMoviesRequested(
        currentPage: currentPage,
      )
          .then((value) {
        discoverMovieModel = discoverMovieModel
            .copyWith(results: [...prevResults!, ...value.results!]);
      });
    }
  }

  Future<void> fetchMoviesFromDb() async {
    discoverMovieModel = DiscoverMovieModel();
    final storedMovies = await appDb.getMovies().then((value) {
      return value
          .map((e) => Results(
              originalTitle: e.originalTitle,
              backdropPath: e.backdropPath,
              overview: e.overview,
              voteAverage: e.voteAverage,
              id: e.id))
          .toList();
    });
    discoverMovieModel = DiscoverMovieModel(results: storedMovies);
  }

  Future<void> insertInDb() async {
    if (discoverMovieModel.results != null) {
      final movieList = discoverMovieModel.results!
          .map((e) => MovieCompanion(
                originalTitle: Value(e.originalTitle ?? ''),
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
  Future fetchRecommendedMovies({required String movieId}) async {
    isLoading = true;
    try {
      final data = await _discoverRepository.recommendedMoviesRequested(
          movieId: movieId);
      recommendedMovieModel = data;
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
      if (!await ConnectionUtils.isNetworkConnected()) {
        final tempResults = discoverMovieModel.results;
        discoverMovieModel.results = tempResults
            ?.where((element) => (element.originalTitle ?? '')
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        discoverMovieModel =
            await _discoverRepository.searchMoviesRequested(query: query);
      }
      isLoading = false;
    }
  }

  Future<String> getMovieTrailerId({required int movieId}) async {
    try {
      final data =
          await _discoverRepository.getMovieTrailerId(movieId: movieId);
      return data;
    } catch (e) {
      rethrow;
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
