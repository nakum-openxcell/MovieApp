import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moviedb_demo/core/network/endpoints/endpoints.dart';
import 'package:moviedb_demo/di/service_locator.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

class DiscoverMovieDetailsPage extends StatelessWidget {
  DiscoverMovieDetailsPage({Key? key}) : super(key: key) {
    discoverStore.fetchMoviesDetails();
  }

  final discoverStore = getIt.get<DiscoverStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              imageUrl: '${Endpoints.imageUrl}${movie?.backdropPath ?? ''}',
              height: 150.h,
              fit: BoxFit.cover,
            ),
          ],
        )
      ],
    );
  }
}
