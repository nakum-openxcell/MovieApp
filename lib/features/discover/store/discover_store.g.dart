// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DiscoverStore on _DiscoverStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_DiscoverStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isGridViewEnabledAtom =
      Atom(name: '_DiscoverStore.isGridViewEnabled', context: context);

  @override
  bool get isGridViewEnabled {
    _$isGridViewEnabledAtom.reportRead();
    return super.isGridViewEnabled;
  }

  @override
  set isGridViewEnabled(bool value) {
    _$isGridViewEnabledAtom.reportWrite(value, super.isGridViewEnabled, () {
      super.isGridViewEnabled = value;
    });
  }

  late final _$isSearchEnabledAtom =
      Atom(name: '_DiscoverStore.isSearchEnabled', context: context);

  @override
  bool get isSearchEnabled {
    _$isSearchEnabledAtom.reportRead();
    return super.isSearchEnabled;
  }

  @override
  set isSearchEnabled(bool value) {
    _$isSearchEnabledAtom.reportWrite(value, super.isSearchEnabled, () {
      super.isSearchEnabled = value;
    });
  }

  late final _$discoverMovieModelAtom =
      Atom(name: '_DiscoverStore.discoverMovieModel', context: context);

  @override
  DiscoverMovieModel get discoverMovieModel {
    _$discoverMovieModelAtom.reportRead();
    return super.discoverMovieModel;
  }

  @override
  set discoverMovieModel(DiscoverMovieModel value) {
    _$discoverMovieModelAtom.reportWrite(value, super.discoverMovieModel, () {
      super.discoverMovieModel = value;
    });
  }

  late final _$recommendedMovieModelAtom =
      Atom(name: '_DiscoverStore.recommendedMovieModel', context: context);

  @override
  DiscoverMovieModel get recommendedMovieModel {
    _$recommendedMovieModelAtom.reportRead();
    return super.recommendedMovieModel;
  }

  @override
  set recommendedMovieModel(DiscoverMovieModel value) {
    _$recommendedMovieModelAtom.reportWrite(value, super.recommendedMovieModel,
        () {
      super.recommendedMovieModel = value;
    });
  }

  late final _$movieDetailsModelAtom =
      Atom(name: '_DiscoverStore.movieDetailsModel', context: context);

  @override
  MovieDetailsModel get movieDetailsModel {
    _$movieDetailsModelAtom.reportRead();
    return super.movieDetailsModel;
  }

  @override
  set movieDetailsModel(MovieDetailsModel value) {
    _$movieDetailsModelAtom.reportWrite(value, super.movieDetailsModel, () {
      super.movieDetailsModel = value;
    });
  }

  late final _$fetchMoviesRequestedAsyncAction =
      AsyncAction('_DiscoverStore.fetchMoviesRequested', context: context);

  @override
  Future<void> fetchMoviesRequested() {
    return _$fetchMoviesRequestedAsyncAction
        .run(() => super.fetchMoviesRequested());
  }

  late final _$nextPageAsyncAction =
      AsyncAction('_DiscoverStore.nextPage', context: context);

  @override
  Future<void> nextPage() {
    return _$nextPageAsyncAction.run(() => super.nextPage());
  }

  late final _$fetchMoviesDetailsAsyncAction =
      AsyncAction('_DiscoverStore.fetchMoviesDetails', context: context);

  @override
  Future<dynamic> fetchMoviesDetails({required String movieId}) {
    return _$fetchMoviesDetailsAsyncAction
        .run(() => super.fetchMoviesDetails(movieId: movieId));
  }

  late final _$fetchRecommendedMoviesAsyncAction =
      AsyncAction('_DiscoverStore.fetchRecommendedMovies', context: context);

  @override
  Future<dynamic> fetchRecommendedMovies({required String movieId}) {
    return _$fetchRecommendedMoviesAsyncAction
        .run(() => super.fetchRecommendedMovies(movieId: movieId));
  }

  late final _$searchMoviesAsyncAction =
      AsyncAction('_DiscoverStore.searchMovies', context: context);

  @override
  Future<dynamic> searchMovies({required String query}) {
    return _$searchMoviesAsyncAction
        .run(() => super.searchMovies(query: query));
  }

  late final _$_DiscoverStoreActionController =
      ActionController(name: '_DiscoverStore', context: context);

  @override
  void updateLayout() {
    final _$actionInfo = _$_DiscoverStoreActionController.startAction(
        name: '_DiscoverStore.updateLayout');
    try {
      return super.updateLayout();
    } finally {
      _$_DiscoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearch() {
    final _$actionInfo = _$_DiscoverStoreActionController.startAction(
        name: '_DiscoverStore.updateSearch');
    try {
      return super.updateSearch();
    } finally {
      _$_DiscoverStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isGridViewEnabled: ${isGridViewEnabled},
isSearchEnabled: ${isSearchEnabled},
discoverMovieModel: ${discoverMovieModel},
recommendedMovieModel: ${recommendedMovieModel},
movieDetailsModel: ${movieDetailsModel}
    ''';
  }
}
