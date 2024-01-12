import 'package:flutter/material.dart';
import 'package:moviedb_demo/features/discover/view/discover_movie_details_page.dart';
import 'package:moviedb_demo/features/discover/view/discover_page.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (BuildContext context) => DiscoverPage(),
    '/discover_movie_details_page': (BuildContext context) =>
        const DiscoverMovieDetailsPage(),
  };
}
