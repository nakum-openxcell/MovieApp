import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_details.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_poster.dart';

class DiscoverMovieDetailsPage extends StatelessWidget {
  DiscoverMovieDetailsPage({Key? key, required this.movieId})
      : super(key: key) {
    discoverStore.fetchMoviesDetails(movieId: movieId);
    discoverStore.fetchRecommendedMovies(movieId: movieId);
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieDetails(movie: movie),
                      Gap(10.h),
                      if (discoverStore
                              .recommendedMovieModel.results?.isNotEmpty ==
                          true)
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Movies Like this',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              Gap(5.h),
                              SizedBox(
                                height: 150.h,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 0.6),
                                  itemBuilder: (context, index) {
                                    final movie = discoverStore
                                        .recommendedMovieModel.results?[index];
                                    return Stack(
                                      children: [
                                        CachedNetworkImage(
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Center(
                                                      child: Center(
                                                        child: Text('No Image'),
                                                      ),
                                                    ),
                                            imageUrl:
                                                '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}'),
                                        Container(
                                          color: Colors.black.withOpacity(0.5),
                                          child: Center(
                                              child: Text(
                                            movie?.originalTitle ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: Colors.white),
                                          )),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: discoverStore
                                      .recommendedMovieModel.results?.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
