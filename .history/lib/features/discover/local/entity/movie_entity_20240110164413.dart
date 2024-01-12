import 'package:drift/drift.dart';

class Movie extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get originalTitle => text()();
  TextColumn get overview => text()();
  RealColumn get voteAverage => real().named('vote_average')();
  TextColumn get backdropPath => text().named('backdrop_path')();
}
