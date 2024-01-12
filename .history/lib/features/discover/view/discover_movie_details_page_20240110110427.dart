import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mobx/mobx.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/movie_details_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

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
            final MovieDetailsModel movie =
                discoverStore.movieDetailsModel.result;
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl:
                              '${Endpoints.imageUrl}${movie.backdropPath ?? ''}',
                          height: 200.h,
                          fit: BoxFit.cover,
                        )),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Gap(10.h),
                Text(
                  movie.title ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            );
        }
      }),
    );
  }
}
