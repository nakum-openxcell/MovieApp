import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/data/repositories/discover_repository.dart';

part 'discover_store.g.dart';

class DiscoverStore = _DiscoverStore with _$DiscoverStore;

abstract class _DiscoverStore with Store {
  _DiscoverStore(DiscoverRepository discoverRepository)
      : _discoverRepository = discoverRepository;

  late final DiscoverRepository _discoverRepository;

  @observable
  bool isLoading = false;

  @observable
  DiscoverMovieModel discoverMovieModel = DiscoverMovieModel();

  @action
  Future<void> fetchMoviesRequested() async {
    isLoading = true;
    discoverMovieModel = await _discoverRepository.fetchMoviesRequested();
    isLoading = false;
  }
}
