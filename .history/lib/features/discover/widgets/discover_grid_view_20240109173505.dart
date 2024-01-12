import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';

class DiscoverGridView extends StatelessWidget {
  const DiscoverGridView({super.key, required this.movies});
  final DiscoverMovieModel movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        final movie = movies.results?[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/discover_movie_details_page',
                arguments: {'movieId': movie?.id});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
                height: 150.h,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                movie?.originalTitle ?? '',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text('⭐️ ${movie?.voteAverage ?? ''}'),
              SizedBox(
                height: 10.w,
              ),
              Text(
                movie?.overview ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      },
      itemCount: movies.results?.length,
    );
  }
}
