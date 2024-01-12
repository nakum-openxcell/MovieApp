import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/core/network/client/dio_exception.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/view/discover_movie_details_page.dart';

class DiscoverGridView extends StatefulWidget {
  const DiscoverGridView(
      {super.key, required this.movies, required this.scrollController});
  final DiscoverMovieModel movies;
  final ScrollController scrollController;

  @override
  State<DiscoverGridView> createState() => _DiscoverGridViewState();
}

class _DiscoverGridViewState extends State<DiscoverGridView> {
  final discoverStore = getIt.get<DiscoverStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        discoverStore.nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.5,
      ),
      itemBuilder: (context, index) {
        final movie = widget.movies.results?[index];
        return GestureDetector(
          onTap: () async {
            try {
              await discoverStore
                  .getMovieTrailerId(movieId: movie?.id ?? 0)
                  .then((value) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DiscoverMovieDetailsPage(
                        movieId: movie?.id.toString() ?? '',
                        youtubeId: value)));
              });
            } on DioError catch (e) {
              final message = DioExceptions.fromDioError(e);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message.message),
              ));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
                errorWidget: (context, url, error) => const Center(
                  child: Text('No Image Found'),
                ),
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
              Text('⭐️ ${(movie?.voteAverage as num).toStringAsFixed(1)}'),
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
      itemCount: widget.movies.results?.length,
    );
  }
}
