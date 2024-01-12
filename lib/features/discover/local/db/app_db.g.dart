// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $MovieTable extends Movie with TableInfo<$MovieTable, MovieData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _originalTitleMeta =
      const VerificationMeta('originalTitle');
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
      'original_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _overviewMeta =
      const VerificationMeta('overview');
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
      'overview', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _backdropPathMeta =
      const VerificationMeta('backdropPath');
  @override
  late final GeneratedColumn<String> backdropPath = GeneratedColumn<String>(
      'backdrop_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, originalTitle, overview, voteAverage, backdropPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movie';
  @override
  VerificationContext validateIntegrity(Insertable<MovieData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_title')) {
      context.handle(
          _originalTitleMeta,
          originalTitle.isAcceptableOrUnknown(
              data['original_title']!, _originalTitleMeta));
    } else if (isInserting) {
      context.missing(_originalTitleMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    if (data.containsKey('backdrop_path')) {
      context.handle(
          _backdropPathMeta,
          backdropPath.isAcceptableOrUnknown(
              data['backdrop_path']!, _backdropPathMeta));
    } else if (isInserting) {
      context.missing(_backdropPathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      originalTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}original_title'])!,
      overview: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overview'])!,
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
      backdropPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_path'])!,
    );
  }

  @override
  $MovieTable createAlias(String alias) {
    return $MovieTable(attachedDatabase, alias);
  }
}

class MovieData extends DataClass implements Insertable<MovieData> {
  final int id;
  final String originalTitle;
  final String overview;
  final double voteAverage;
  final String backdropPath;
  const MovieData(
      {required this.id,
      required this.originalTitle,
      required this.overview,
      required this.voteAverage,
      required this.backdropPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['original_title'] = Variable<String>(originalTitle);
    map['overview'] = Variable<String>(overview);
    map['vote_average'] = Variable<double>(voteAverage);
    map['backdrop_path'] = Variable<String>(backdropPath);
    return map;
  }

  MovieCompanion toCompanion(bool nullToAbsent) {
    return MovieCompanion(
      id: Value(id),
      originalTitle: Value(originalTitle),
      overview: Value(overview),
      voteAverage: Value(voteAverage),
      backdropPath: Value(backdropPath),
    );
  }

  factory MovieData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieData(
      id: serializer.fromJson<int>(json['id']),
      originalTitle: serializer.fromJson<String>(json['originalTitle']),
      overview: serializer.fromJson<String>(json['overview']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
      backdropPath: serializer.fromJson<String>(json['backdropPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalTitle': serializer.toJson<String>(originalTitle),
      'overview': serializer.toJson<String>(overview),
      'voteAverage': serializer.toJson<double>(voteAverage),
      'backdropPath': serializer.toJson<String>(backdropPath),
    };
  }

  MovieData copyWith(
          {int? id,
          String? originalTitle,
          String? overview,
          double? voteAverage,
          String? backdropPath}) =>
      MovieData(
        id: id ?? this.id,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        voteAverage: voteAverage ?? this.voteAverage,
        backdropPath: backdropPath ?? this.backdropPath,
      );
  @override
  String toString() {
    return (StringBuffer('MovieData(')
          ..write('id: $id, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('backdropPath: $backdropPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, originalTitle, overview, voteAverage, backdropPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieData &&
          other.id == this.id &&
          other.originalTitle == this.originalTitle &&
          other.overview == this.overview &&
          other.voteAverage == this.voteAverage &&
          other.backdropPath == this.backdropPath);
}

class MovieCompanion extends UpdateCompanion<MovieData> {
  final Value<int> id;
  final Value<String> originalTitle;
  final Value<String> overview;
  final Value<double> voteAverage;
  final Value<String> backdropPath;
  const MovieCompanion({
    this.id = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.overview = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.backdropPath = const Value.absent(),
  });
  MovieCompanion.insert({
    this.id = const Value.absent(),
    required String originalTitle,
    required String overview,
    required double voteAverage,
    required String backdropPath,
  })  : originalTitle = Value(originalTitle),
        overview = Value(overview),
        voteAverage = Value(voteAverage),
        backdropPath = Value(backdropPath);
  static Insertable<MovieData> custom({
    Expression<int>? id,
    Expression<String>? originalTitle,
    Expression<String>? overview,
    Expression<double>? voteAverage,
    Expression<String>? backdropPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalTitle != null) 'original_title': originalTitle,
      if (overview != null) 'overview': overview,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (backdropPath != null) 'backdrop_path': backdropPath,
    });
  }

  MovieCompanion copyWith(
      {Value<int>? id,
      Value<String>? originalTitle,
      Value<String>? overview,
      Value<double>? voteAverage,
      Value<String>? backdropPath}) {
    return MovieCompanion(
      id: id ?? this.id,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      voteAverage: voteAverage ?? this.voteAverage,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    if (backdropPath.present) {
      map['backdrop_path'] = Variable<String>(backdropPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieCompanion(')
          ..write('id: $id, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('overview: $overview, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('backdropPath: $backdropPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $MovieTable movie = $MovieTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movie];
}
