import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
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
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.mobile ||
            event == ConnectivityResult.wifi) {
          discoverStore.fetchMoviesRequested();
        } else if (event == ConnectivityResult.none) {
          discoverStore.fetchMoviesFromDb();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No internet connection!')));
        }
      },
    );
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
    _connectivitySubscription.cancel();

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
            SearchMovieWidget(
              discoverStore: discoverStore,
              searchEC: searchEC,
              onSearchChanged: _onSearchChanged,
            ),
            Expanded(
              child: Observer(
                builder: (context) {
                  final DiscoverMovieModel movies =
                      discoverStore.discoverMovieModel;
                  if (discoverStore.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (movies.results?.isEmpty ?? true) {
                    return Center(
                      child: Text(movies.error ?? ''),
                    );
                  } else {
                    return Column(
                      children: [
                        discoverStore.isGridViewEnabled
                            ? Expanded(child: DiscoverGridView(movies: movies))
                            : Expanded(child: DiscoverListView(movies: movies))
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
