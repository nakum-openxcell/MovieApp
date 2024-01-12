import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({Key? key}) : super(key: key) {
    discoverStore.fetchMoviesRequested();
  }

  final discoverStore = getIt.get<DiscoverStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Observer(
        builder: (context) {
          switch (discoverStore.discoverMovieModel.status) {
            case FutureStatus.pending:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FutureStatus.rejected:
              return Center(
                child: Text(discoverStore.discoverMovieModel.error.toString()),
              );
            case FutureStatus.fulfilled:
              final DiscoverMovieModel movies =
                  discoverStore.discoverMovieModel.result;
              return ListView.builder(
                itemCount: movies.results?.length,
                itemBuilder: (context, index) =>
                    Text(movies.results?[index].title ?? ''),
              );
          }
        },
      ),
    );
  }
}
