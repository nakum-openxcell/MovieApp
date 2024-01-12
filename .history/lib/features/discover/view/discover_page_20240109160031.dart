import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class DiscoverPage extends StatelessWidget {
  DiscoverPage({Key? key}) : super(key: key);

  final discoverStore = getIt.get<DiscoverStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Observer(
          builder: (context) => FutureBuilder(
                future: discoverStore.fetchMoviesRequested(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final movies =
                        (snapshot.data as DiscoverMovieModel).results;
                    return ListView.builder(
                      itemBuilder: (context, index) =>
                          Text(movies?[index].title ?? ''),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  return Container();
                },
              )),
    );
  }
}
