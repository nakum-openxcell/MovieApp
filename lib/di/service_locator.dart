import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviedb_demo/core/network/client/dio_client.dart';
import 'package:moviedb_demo/features/discover/data/api/discover_api.dart';
import 'package:moviedb_demo/features/discover/data/repositories/discover_repository.dart';
import 'package:moviedb_demo/features/discover/local/db/app_db.dart';
import 'package:moviedb_demo/features/discover/store/discover_store.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(DioClient(Dio()));
  getIt.registerSingleton<AppDb>(AppDb());

  getIt.registerSingleton<DiscoverApi>(DiscoverApi());
  getIt.registerSingleton<DiscoverRepository>(DiscoverRepository());
  getIt.registerSingleton<DiscoverStore>(DiscoverStore());
}