import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/data/repositories/discover_repository.dart';

part 'discover_store.g.dart';

class DiscoverStore = _DiscoverStore with _$DiscoverStore;

abstract class _DiscoverStore with Store {
  final DiscoverRepository _discoverRepository =
      getIt.get<DiscoverRepository>();

  int currentPage = 1;

  @observable
  bool isLoading = false;

  @observable
  bool isGridViewEnabled = false;

  @observable
  bool isSearchEnabled = false;

  @observable
  DiscoverMovieModel discoverMovieModel = DiscoverMovieModel();

  @observable
  ObservableFuture<MovieDetailsModel> movieDetailsModel =
      ObservableFuture<MovieDetailsModel>(Future.value(MovieDetailsModel()));

  @action
  Future<void> fetchMoviesRequested() async {
    isLoading = true;
    try {
      final data = await _discoverRepository.fetchMoviesRequested(
        currentPage: currentPage,
      );
      discoverMovieModel = data;
      isLoading = false;
    } on DioError catch (e) {
      discoverMovieModel =
          DiscoverMovieModel(error: e.response?.data['status_message']);
      isLoading = false;
    }
  }

  @action
  Future<void> loadMoreMovies() async {
    try {
      final data = await _discoverRepository.fetchMoviesRequested(
        currentPage: currentPage,
      );
      discoverMovieModel.results?.addAll(data.results ?? []);
    } on DioError catch (e) {
      discoverMovieModel =
          DiscoverMovieModel(error: e.response?.data['status_message']);
    }
  }

  @action
  Future fetchMoviesDetails({required String movieId}) async {
    isLoading = true;
    movieDetailsModel = ObservableFuture(
        _discoverRepository.movieDetailsRequested(movieId: movieId));
    isLoading = false;
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
