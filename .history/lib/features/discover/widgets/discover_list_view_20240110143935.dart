import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/data/models/discover_model.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';
import 'package:moviedb_demo/features/discover/view/discover_movie_details_page.dart';

class DiscoverListView extends StatefulWidget {
  const DiscoverListView({super.key, required this.movies});
  final DiscoverMovieModel movies;

  @override
  State<DiscoverListView> createState() => _DiscoverListViewState();
}

class _DiscoverListViewState extends State<DiscoverListView> {
  final scrollController = ScrollController();
  final discoverStore = getIt.get<DiscoverStore>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        discoverStore.currentPage = discoverStore.currentPage + 1;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      separatorBuilder: (context, index) => SizedBox(
        height: 20.h,
      ),
      itemCount: (widget.movies.results?.length ?? 0),
      itemBuilder: (context, index) {
        final movie = widget.movies.results?[index];
        if (index < (widget.movies.results?.length ?? 0)) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DiscoverMovieDetailsPage(
                      movieId: movie?.id.toString() ?? '')));
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) => const Center(
                              child: Text('No Image Found'),
                            ),
                            imageUrl:
                                '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
                            height: 150.h,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              movie?.originalTitle ?? '',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('⭐️ ${movie?.voteAverage ?? ''}'),
                        ],
                      ),
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
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
