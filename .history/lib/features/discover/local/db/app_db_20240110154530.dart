import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:moviedb_demo/features/discover/local/entity/movie_entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'movie.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Movie])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<MovieData>> getMovies() async {
    return await select(movie).get();
  }

  Future<MovieData> getMovieById(int id) async {
    return await (select(movie)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> insertMovie(MovieCompanion data) async {
    return await into(movie).insert(data);
  }

  Future<void> insertMovies(List<MovieCompanion> data) async {
    return await batch((batch) => batch.insertAll(movie, data));
  }

  Future<bool> updateMovie(MovieCompanion data) async {
    return await update(movie).replace(data);
  }

  Future<int> deleteMovie(int id) async {
    return await (delete(movie)..where((tbl) => tbl.id.equals(id))).go();
  }
}
