import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
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
                itemBuilder: (context, index) {
                  final movie = movies.results?[index];
                  return Column(
                    children: [
                      Image.network(
                        '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
                        height: 150.h,
                      ),
                      Text(movie?.originalTitle ?? ''),
                      RatingBarIndicator(
                        rating: movie?.voteAverage?.toDouble() ?? 0.0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 10,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  );
                },
              );
          }
        },
      ),
    );
  }
}
