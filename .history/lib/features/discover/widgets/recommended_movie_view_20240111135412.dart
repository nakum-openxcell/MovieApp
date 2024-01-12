import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/view/discover_movie_details_page.dart';

class RecommendedMoviesView extends StatelessWidget {
  const RecommendedMoviesView({
    super.key,
    required this.discoverStore,
  });

  final DiscoverStore discoverStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Movies Like this',
              style: Theme.of(context).textTheme.titleLarge),
          Gap(5.h),
          SizedBox(
            height: 150.h,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6),
              itemBuilder: (context, index) {
                final movie =
                    discoverStore.recommendedMovieModel.results?[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => DiscoverMovieDetailsPage(
                            movieId: movie?.id.toString() ?? '')));
                  },
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        errorWidget: (context, url, error) => const Center(
                          child: Center(
                            child: Text('No Image'),
                          ),
                        ),
                        imageUrl:
                            '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                            child: Text(
                          movie?.originalTitle ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      )
                    ],
                  ),
                );
              },
              itemCount: discoverStore.recommendedMovieModel.results?.length,
            ),
          ),
        ],
      ),
    );
  }
}
