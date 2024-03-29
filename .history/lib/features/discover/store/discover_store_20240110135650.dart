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
      discoverMovieModel = await _discoverRepository.fetchMoviesRequested(
        currentPage: currentPage,
      );
      isLoading = false;
    } catch (e) {
      isLoading = false;
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
