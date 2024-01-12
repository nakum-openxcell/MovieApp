import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviedb_demo/features/discover/data/api/discover_api.dart';
import 'package:moviedb_demo/features/discover/data/repositories/discover_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(Dio());

  getIt.registerSingleton<DiscoverApi>(DiscoverApi(getIt()));
  getIt.registerSingleton<DiscoverRepository>(
      DiscoverRepository(discoverApi: getIt()));
}
