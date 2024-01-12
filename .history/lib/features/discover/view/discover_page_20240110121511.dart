import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_app_bar.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_grid_view.dart';
import 'package:moviedb_demo/features/discover/widgets/discover_list_view.dart';
import 'package:moviedb_demo/features/discover/widgets/search_movie_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final discoverStore = getIt.get<DiscoverStore>();
  Timer? _debounce;
  TextEditingController searchEC = TextEditingController();

  final PagingController<int, MovieDetailsModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      fetchMovies();
    });
  }

  Future<void> fetchMovies() async {
    await discoverStore.fetchMoviesRequested(page: 0);
  }

  void _onSearchChanged({required String value}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      await discoverStore
          .searchMovies(query: value)
          .then((value) => {searchEC.text = value});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: DiscoverAppBar(
          discoverStore: discoverStore,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return discoverStore.fetchMoviesRequested();
        },
        child: Column(
          children: [
            Observer(builder: (context) {
              return SearchMovieWidget(
                discoverStore: discoverStore,
                searchEC: searchEC,
                onSearchChanged: _onSearchChanged,
              );
            }),
            Expanded(
              child: Observer(
                builder: (context) {
                  switch (discoverStore.discoverMovieModel.status) {
                    case FutureStatus.pending:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case FutureStatus.rejected:
                      return Center(
                        child: Text(
                            discoverStore.discoverMovieModel.error.toString()),
                      );
                    case FutureStatus.fulfilled:
                      final DiscoverMovieModel movies =
                          discoverStore.discoverMovieModel.result;
                      return Column(
                        children: [
                          discoverStore.isGridViewEnabled
                              ? Expanded(
                                  child: DiscoverGridView(movies: movies))
                              : Expanded(
                                  child: DiscoverListView(movies: movies))
                        ],
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
