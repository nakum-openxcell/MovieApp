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

  int currentPage = 0;

  @observable
  bool isLoading = false;

  @observable
  bool isGridViewEnabled = false;

  @observable
  bool isSearchEnabled = false;

  @observable
  ObservableFuture<DiscoverMovieModel> discoverMovieModel =
      ObservableFuture<DiscoverMovieModel>(Future.value(DiscoverMovieModel()));

  @observable
  ObservableFuture<MovieDetailsModel> movieDetailsModel =
      ObservableFuture<MovieDetailsModel>(Future.value(MovieDetailsModel()));

  @action
  Future<void> fetchMoviesRequested() async {
    isLoading = true;
    discoverMovieModel =
        ObservableFuture(_discoverRepository.fetchMoviesRequested());
    isLoading = false;
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
      discoverMovieModel = ObservableFuture(
          _discoverRepository.searchMoviesRequested(query: query));
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
