import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class DiscoverMovieDetailsPage extends StatefulWidget {
  const DiscoverMovieDetailsPage({Key? key, required this.movieId})
      : super(key: key);

  final String movieId;

  @override
  State<DiscoverMovieDetailsPage> createState() =>
      _DiscoverMovieDetailsPageState();
}

class _DiscoverMovieDetailsPageState extends State<DiscoverMovieDetailsPage> {
  final discoverStore = getIt.get<DiscoverStore>();

  @override
  void initState() {
    super.initState();
    discoverStore.fetchMoviesDetails(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        switch (discoverStore.movieDetailsModel.status) {
          case FutureStatus.pending:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case FutureStatus.rejected:
            return Center(
              child: Text(
                discoverStore.movieDetailsModel.error.toString(),
              ),
            );
          case FutureStatus.fulfilled:
            return const Text('Hi');
        }
      }),
    );
  }
}
