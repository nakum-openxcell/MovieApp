import 'dart:async';
import 'dart:developer';

import '../api/home_api.dart';
import '../models/discover_movie_model.dart';

class HomeRepository {
  final HomeApi homeApi;

  HomeRepository({required this.homeApi});

  Future<DiscoverMovieModel> getUserRequested() async {
    try {
      final rawData = await homeApi.getUserApi();
      return DiscoverMovieModel.fromJson(rawData);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
