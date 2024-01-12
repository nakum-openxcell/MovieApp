import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_details.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_poster.dart';

class DiscoverMovieDetailsPage extends StatelessWidget {
  DiscoverMovieDetailsPage({Key? key, required this.movieId})
      : super(key: key) {
    discoverStore.fetchMoviesDetails(movieId: movieId);
  }

  final String movieId;
  final discoverStore = getIt.get<DiscoverStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        final MovieDetailsModel movie = discoverStore.movieDetailsModel;
        if (discoverStore.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviePoster(movie: movie),
              Gap(10.h),
              MovieDetails(movie: movie),
              Gap(10.h),
              Column(
                children: [
                  Text('Movies Like this',
                      style: Theme.of(context).textTheme.titleLarge),
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.6),
                      itemBuilder: (context, index) {
                        return const Card();
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              )
            ],
          );
        }
      }),
    );
  }
}
