import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        actions: [
          Observer(
            builder: (context) => InkWell(
                onTap: () {
                  discoverStore.isGridViewEnabled =
                      !discoverStore.isGridViewEnabled;
                },
                child: Icon(discoverStore.isGridViewEnabled
                    ? Icons.list
                    : Icons.grid_3x3)),
          ),
        ],
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
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.h,
                ),
                itemCount: movies.results?.length ?? 0,
                itemBuilder: (context, index) {
                  final movie = movies.results?[index];
                  return Column(
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
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
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
                  );
                },
              );
          }
        },
      ),
    );
  }
}
