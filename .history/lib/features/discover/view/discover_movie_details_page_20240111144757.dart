import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_details.dart';
import 'package:moviedb_demo/features/discover/widgets/movie_poster.dart';
import 'package:moviedb_demo/features/discover/widgets/recommended_movie_view.dart';

class DiscoverMovieDetailsPage extends StatelessWidget {
  DiscoverMovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

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
                        RecommendedMoviesView(discoverStore: discoverStore),
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
