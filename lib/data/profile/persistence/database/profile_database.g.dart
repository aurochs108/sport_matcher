// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_database.dart';

// ignore_for_file: type=lint
class $ProfileEntityTable extends ProfileEntity
    with TableInfo<$ProfileEntityTable, ProfileEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _profileImagePathMeta =
      const VerificationMeta('profileImagePath');
  @override
  late final GeneratedColumn<String> profileImagePath = GeneratedColumn<String>(
      'profile_image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bikeMeta = const VerificationMeta('bike');
  @override
  late final GeneratedColumn<bool> bike = GeneratedColumn<bool>(
      'bike', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("bike" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _climbingMeta =
      const VerificationMeta('climbing');
  @override
  late final GeneratedColumn<bool> climbing = GeneratedColumn<bool>(
      'climbing', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("climbing" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _footballMeta =
      const VerificationMeta('football');
  @override
  late final GeneratedColumn<bool> football = GeneratedColumn<bool>(
      'football', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("football" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hockeyMeta = const VerificationMeta('hockey');
  @override
  late final GeneratedColumn<bool> hockey = GeneratedColumn<bool>(
      'hockey', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("hockey" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _pingPongMeta =
      const VerificationMeta('pingPong');
  @override
  late final GeneratedColumn<bool> pingPong = GeneratedColumn<bool>(
      'ping_pong', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ping_pong" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _runningMeta =
      const VerificationMeta('running');
  @override
  late final GeneratedColumn<bool> running = GeneratedColumn<bool>(
      'running', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("running" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _tennisMeta = const VerificationMeta('tennis');
  @override
  late final GeneratedColumn<bool> tennis = GeneratedColumn<bool>(
      'tennis', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("tennis" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _voleyballMeta =
      const VerificationMeta('voleyball');
  @override
  late final GeneratedColumn<bool> voleyball = GeneratedColumn<bool>(
      'voleyball', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("voleyball" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        profileImagePath,
        bike,
        climbing,
        football,
        hockey,
        pingPong,
        running,
        tennis,
        voleyball
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_entity';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('profile_image_path')) {
      context.handle(
          _profileImagePathMeta,
          profileImagePath.isAcceptableOrUnknown(
              data['profile_image_path']!, _profileImagePathMeta));
    } else if (isInserting) {
      context.missing(_profileImagePathMeta);
    }
    if (data.containsKey('bike')) {
      context.handle(
          _bikeMeta, bike.isAcceptableOrUnknown(data['bike']!, _bikeMeta));
    }
    if (data.containsKey('climbing')) {
      context.handle(_climbingMeta,
          climbing.isAcceptableOrUnknown(data['climbing']!, _climbingMeta));
    }
    if (data.containsKey('football')) {
      context.handle(_footballMeta,
          football.isAcceptableOrUnknown(data['football']!, _footballMeta));
    }
    if (data.containsKey('hockey')) {
      context.handle(_hockeyMeta,
          hockey.isAcceptableOrUnknown(data['hockey']!, _hockeyMeta));
    }
    if (data.containsKey('ping_pong')) {
      context.handle(_pingPongMeta,
          pingPong.isAcceptableOrUnknown(data['ping_pong']!, _pingPongMeta));
    }
    if (data.containsKey('running')) {
      context.handle(_runningMeta,
          running.isAcceptableOrUnknown(data['running']!, _runningMeta));
    }
    if (data.containsKey('tennis')) {
      context.handle(_tennisMeta,
          tennis.isAcceptableOrUnknown(data['tennis']!, _tennisMeta));
    }
    if (data.containsKey('voleyball')) {
      context.handle(_voleyballMeta,
          voleyball.isAcceptableOrUnknown(data['voleyball']!, _voleyballMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileEntityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      profileImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_image_path'])!,
      bike: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}bike'])!,
      climbing: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}climbing'])!,
      football: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}football'])!,
      hockey: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}hockey'])!,
      pingPong: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ping_pong'])!,
      running: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}running'])!,
      tennis: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}tennis'])!,
      voleyball: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}voleyball'])!,
    );
  }

  @override
  $ProfileEntityTable createAlias(String alias) {
    return $ProfileEntityTable(attachedDatabase, alias);
  }
}

class ProfileEntityData extends DataClass
    implements Insertable<ProfileEntityData> {
  final int id;
  final String name;
  final String profileImagePath;
  final bool bike;
  final bool climbing;
  final bool football;
  final bool hockey;
  final bool pingPong;
  final bool running;
  final bool tennis;
  final bool voleyball;
  const ProfileEntityData(
      {required this.id,
      required this.name,
      required this.profileImagePath,
      required this.bike,
      required this.climbing,
      required this.football,
      required this.hockey,
      required this.pingPong,
      required this.running,
      required this.tennis,
      required this.voleyball});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['profile_image_path'] = Variable<String>(profileImagePath);
    map['bike'] = Variable<bool>(bike);
    map['climbing'] = Variable<bool>(climbing);
    map['football'] = Variable<bool>(football);
    map['hockey'] = Variable<bool>(hockey);
    map['ping_pong'] = Variable<bool>(pingPong);
    map['running'] = Variable<bool>(running);
    map['tennis'] = Variable<bool>(tennis);
    map['voleyball'] = Variable<bool>(voleyball);
    return map;
  }

  ProfileEntityCompanion toCompanion(bool nullToAbsent) {
    return ProfileEntityCompanion(
      id: Value(id),
      name: Value(name),
      profileImagePath: Value(profileImagePath),
      bike: Value(bike),
      climbing: Value(climbing),
      football: Value(football),
      hockey: Value(hockey),
      pingPong: Value(pingPong),
      running: Value(running),
      tennis: Value(tennis),
      voleyball: Value(voleyball),
    );
  }

  factory ProfileEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileEntityData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      profileImagePath: serializer.fromJson<String>(json['profileImagePath']),
      bike: serializer.fromJson<bool>(json['bike']),
      climbing: serializer.fromJson<bool>(json['climbing']),
      football: serializer.fromJson<bool>(json['football']),
      hockey: serializer.fromJson<bool>(json['hockey']),
      pingPong: serializer.fromJson<bool>(json['pingPong']),
      running: serializer.fromJson<bool>(json['running']),
      tennis: serializer.fromJson<bool>(json['tennis']),
      voleyball: serializer.fromJson<bool>(json['voleyball']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'profileImagePath': serializer.toJson<String>(profileImagePath),
      'bike': serializer.toJson<bool>(bike),
      'climbing': serializer.toJson<bool>(climbing),
      'football': serializer.toJson<bool>(football),
      'hockey': serializer.toJson<bool>(hockey),
      'pingPong': serializer.toJson<bool>(pingPong),
      'running': serializer.toJson<bool>(running),
      'tennis': serializer.toJson<bool>(tennis),
      'voleyball': serializer.toJson<bool>(voleyball),
    };
  }

  ProfileEntityData copyWith(
          {int? id,
          String? name,
          String? profileImagePath,
          bool? bike,
          bool? climbing,
          bool? football,
          bool? hockey,
          bool? pingPong,
          bool? running,
          bool? tennis,
          bool? voleyball}) =>
      ProfileEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
        profileImagePath: profileImagePath ?? this.profileImagePath,
        bike: bike ?? this.bike,
        climbing: climbing ?? this.climbing,
        football: football ?? this.football,
        hockey: hockey ?? this.hockey,
        pingPong: pingPong ?? this.pingPong,
        running: running ?? this.running,
        tennis: tennis ?? this.tennis,
        voleyball: voleyball ?? this.voleyball,
      );
  ProfileEntityData copyWithCompanion(ProfileEntityCompanion data) {
    return ProfileEntityData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      profileImagePath: data.profileImagePath.present
          ? data.profileImagePath.value
          : this.profileImagePath,
      bike: data.bike.present ? data.bike.value : this.bike,
      climbing: data.climbing.present ? data.climbing.value : this.climbing,
      football: data.football.present ? data.football.value : this.football,
      hockey: data.hockey.present ? data.hockey.value : this.hockey,
      pingPong: data.pingPong.present ? data.pingPong.value : this.pingPong,
      running: data.running.present ? data.running.value : this.running,
      tennis: data.tennis.present ? data.tennis.value : this.tennis,
      voleyball: data.voleyball.present ? data.voleyball.value : this.voleyball,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEntityData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('profileImagePath: $profileImagePath, ')
          ..write('bike: $bike, ')
          ..write('climbing: $climbing, ')
          ..write('football: $football, ')
          ..write('hockey: $hockey, ')
          ..write('pingPong: $pingPong, ')
          ..write('running: $running, ')
          ..write('tennis: $tennis, ')
          ..write('voleyball: $voleyball')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, profileImagePath, bike, climbing,
      football, hockey, pingPong, running, tennis, voleyball);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileEntityData &&
          other.id == this.id &&
          other.name == this.name &&
          other.profileImagePath == this.profileImagePath &&
          other.bike == this.bike &&
          other.climbing == this.climbing &&
          other.football == this.football &&
          other.hockey == this.hockey &&
          other.pingPong == this.pingPong &&
          other.running == this.running &&
          other.tennis == this.tennis &&
          other.voleyball == this.voleyball);
}

class ProfileEntityCompanion extends UpdateCompanion<ProfileEntityData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> profileImagePath;
  final Value<bool> bike;
  final Value<bool> climbing;
  final Value<bool> football;
  final Value<bool> hockey;
  final Value<bool> pingPong;
  final Value<bool> running;
  final Value<bool> tennis;
  final Value<bool> voleyball;
  const ProfileEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.profileImagePath = const Value.absent(),
    this.bike = const Value.absent(),
    this.climbing = const Value.absent(),
    this.football = const Value.absent(),
    this.hockey = const Value.absent(),
    this.pingPong = const Value.absent(),
    this.running = const Value.absent(),
    this.tennis = const Value.absent(),
    this.voleyball = const Value.absent(),
  });
  ProfileEntityCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String profileImagePath,
    this.bike = const Value.absent(),
    this.climbing = const Value.absent(),
    this.football = const Value.absent(),
    this.hockey = const Value.absent(),
    this.pingPong = const Value.absent(),
    this.running = const Value.absent(),
    this.tennis = const Value.absent(),
    this.voleyball = const Value.absent(),
  })  : name = Value(name),
        profileImagePath = Value(profileImagePath);
  static Insertable<ProfileEntityData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? profileImagePath,
    Expression<bool>? bike,
    Expression<bool>? climbing,
    Expression<bool>? football,
    Expression<bool>? hockey,
    Expression<bool>? pingPong,
    Expression<bool>? running,
    Expression<bool>? tennis,
    Expression<bool>? voleyball,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (profileImagePath != null) 'profile_image_path': profileImagePath,
      if (bike != null) 'bike': bike,
      if (climbing != null) 'climbing': climbing,
      if (football != null) 'football': football,
      if (hockey != null) 'hockey': hockey,
      if (pingPong != null) 'ping_pong': pingPong,
      if (running != null) 'running': running,
      if (tennis != null) 'tennis': tennis,
      if (voleyball != null) 'voleyball': voleyball,
    });
  }

  ProfileEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? profileImagePath,
      Value<bool>? bike,
      Value<bool>? climbing,
      Value<bool>? football,
      Value<bool>? hockey,
      Value<bool>? pingPong,
      Value<bool>? running,
      Value<bool>? tennis,
      Value<bool>? voleyball}) {
    return ProfileEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bike: bike ?? this.bike,
      climbing: climbing ?? this.climbing,
      football: football ?? this.football,
      hockey: hockey ?? this.hockey,
      pingPong: pingPong ?? this.pingPong,
      running: running ?? this.running,
      tennis: tennis ?? this.tennis,
      voleyball: voleyball ?? this.voleyball,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (profileImagePath.present) {
      map['profile_image_path'] = Variable<String>(profileImagePath.value);
    }
    if (bike.present) {
      map['bike'] = Variable<bool>(bike.value);
    }
    if (climbing.present) {
      map['climbing'] = Variable<bool>(climbing.value);
    }
    if (football.present) {
      map['football'] = Variable<bool>(football.value);
    }
    if (hockey.present) {
      map['hockey'] = Variable<bool>(hockey.value);
    }
    if (pingPong.present) {
      map['ping_pong'] = Variable<bool>(pingPong.value);
    }
    if (running.present) {
      map['running'] = Variable<bool>(running.value);
    }
    if (tennis.present) {
      map['tennis'] = Variable<bool>(tennis.value);
    }
    if (voleyball.present) {
      map['voleyball'] = Variable<bool>(voleyball.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('profileImagePath: $profileImagePath, ')
          ..write('bike: $bike, ')
          ..write('climbing: $climbing, ')
          ..write('football: $football, ')
          ..write('hockey: $hockey, ')
          ..write('pingPong: $pingPong, ')
          ..write('running: $running, ')
          ..write('tennis: $tennis, ')
          ..write('voleyball: $voleyball')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProfileDatabase extends GeneratedDatabase {
  _$ProfileDatabase(QueryExecutor e) : super(e);
  $ProfileDatabaseManager get managers => $ProfileDatabaseManager(this);
  late final $ProfileEntityTable profileEntity = $ProfileEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [profileEntity];
}

typedef $$ProfileEntityTableCreateCompanionBuilder = ProfileEntityCompanion
    Function({
  Value<int> id,
  required String name,
  required String profileImagePath,
  Value<bool> bike,
  Value<bool> climbing,
  Value<bool> football,
  Value<bool> hockey,
  Value<bool> pingPong,
  Value<bool> running,
  Value<bool> tennis,
  Value<bool> voleyball,
});
typedef $$ProfileEntityTableUpdateCompanionBuilder = ProfileEntityCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> profileImagePath,
  Value<bool> bike,
  Value<bool> climbing,
  Value<bool> football,
  Value<bool> hockey,
  Value<bool> pingPong,
  Value<bool> running,
  Value<bool> tennis,
  Value<bool> voleyball,
});

class $$ProfileEntityTableFilterComposer
    extends Composer<_$ProfileDatabase, $ProfileEntityTable> {
  $$ProfileEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileImagePath => $composableBuilder(
      column: $table.profileImagePath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get bike => $composableBuilder(
      column: $table.bike, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get climbing => $composableBuilder(
      column: $table.climbing, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get football => $composableBuilder(
      column: $table.football, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hockey => $composableBuilder(
      column: $table.hockey, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pingPong => $composableBuilder(
      column: $table.pingPong, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get running => $composableBuilder(
      column: $table.running, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get tennis => $composableBuilder(
      column: $table.tennis, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get voleyball => $composableBuilder(
      column: $table.voleyball, builder: (column) => ColumnFilters(column));
}

class $$ProfileEntityTableOrderingComposer
    extends Composer<_$ProfileDatabase, $ProfileEntityTable> {
  $$ProfileEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileImagePath => $composableBuilder(
      column: $table.profileImagePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get bike => $composableBuilder(
      column: $table.bike, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get climbing => $composableBuilder(
      column: $table.climbing, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get football => $composableBuilder(
      column: $table.football, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hockey => $composableBuilder(
      column: $table.hockey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pingPong => $composableBuilder(
      column: $table.pingPong, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get running => $composableBuilder(
      column: $table.running, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get tennis => $composableBuilder(
      column: $table.tennis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get voleyball => $composableBuilder(
      column: $table.voleyball, builder: (column) => ColumnOrderings(column));
}

class $$ProfileEntityTableAnnotationComposer
    extends Composer<_$ProfileDatabase, $ProfileEntityTable> {
  $$ProfileEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get profileImagePath => $composableBuilder(
      column: $table.profileImagePath, builder: (column) => column);

  GeneratedColumn<bool> get bike =>
      $composableBuilder(column: $table.bike, builder: (column) => column);

  GeneratedColumn<bool> get climbing =>
      $composableBuilder(column: $table.climbing, builder: (column) => column);

  GeneratedColumn<bool> get football =>
      $composableBuilder(column: $table.football, builder: (column) => column);

  GeneratedColumn<bool> get hockey =>
      $composableBuilder(column: $table.hockey, builder: (column) => column);

  GeneratedColumn<bool> get pingPong =>
      $composableBuilder(column: $table.pingPong, builder: (column) => column);

  GeneratedColumn<bool> get running =>
      $composableBuilder(column: $table.running, builder: (column) => column);

  GeneratedColumn<bool> get tennis =>
      $composableBuilder(column: $table.tennis, builder: (column) => column);

  GeneratedColumn<bool> get voleyball =>
      $composableBuilder(column: $table.voleyball, builder: (column) => column);
}

class $$ProfileEntityTableTableManager extends RootTableManager<
    _$ProfileDatabase,
    $ProfileEntityTable,
    ProfileEntityData,
    $$ProfileEntityTableFilterComposer,
    $$ProfileEntityTableOrderingComposer,
    $$ProfileEntityTableAnnotationComposer,
    $$ProfileEntityTableCreateCompanionBuilder,
    $$ProfileEntityTableUpdateCompanionBuilder,
    (
      ProfileEntityData,
      BaseReferences<_$ProfileDatabase, $ProfileEntityTable, ProfileEntityData>
    ),
    ProfileEntityData,
    PrefetchHooks Function()> {
  $$ProfileEntityTableTableManager(
      _$ProfileDatabase db, $ProfileEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> profileImagePath = const Value.absent(),
            Value<bool> bike = const Value.absent(),
            Value<bool> climbing = const Value.absent(),
            Value<bool> football = const Value.absent(),
            Value<bool> hockey = const Value.absent(),
            Value<bool> pingPong = const Value.absent(),
            Value<bool> running = const Value.absent(),
            Value<bool> tennis = const Value.absent(),
            Value<bool> voleyball = const Value.absent(),
          }) =>
              ProfileEntityCompanion(
            id: id,
            name: name,
            profileImagePath: profileImagePath,
            bike: bike,
            climbing: climbing,
            football: football,
            hockey: hockey,
            pingPong: pingPong,
            running: running,
            tennis: tennis,
            voleyball: voleyball,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String profileImagePath,
            Value<bool> bike = const Value.absent(),
            Value<bool> climbing = const Value.absent(),
            Value<bool> football = const Value.absent(),
            Value<bool> hockey = const Value.absent(),
            Value<bool> pingPong = const Value.absent(),
            Value<bool> running = const Value.absent(),
            Value<bool> tennis = const Value.absent(),
            Value<bool> voleyball = const Value.absent(),
          }) =>
              ProfileEntityCompanion.insert(
            id: id,
            name: name,
            profileImagePath: profileImagePath,
            bike: bike,
            climbing: climbing,
            football: football,
            hockey: hockey,
            pingPong: pingPong,
            running: running,
            tennis: tennis,
            voleyball: voleyball,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfileEntityTableProcessedTableManager = ProcessedTableManager<
    _$ProfileDatabase,
    $ProfileEntityTable,
    ProfileEntityData,
    $$ProfileEntityTableFilterComposer,
    $$ProfileEntityTableOrderingComposer,
    $$ProfileEntityTableAnnotationComposer,
    $$ProfileEntityTableCreateCompanionBuilder,
    $$ProfileEntityTableUpdateCompanionBuilder,
    (
      ProfileEntityData,
      BaseReferences<_$ProfileDatabase, $ProfileEntityTable, ProfileEntityData>
    ),
    ProfileEntityData,
    PrefetchHooks Function()>;

class $ProfileDatabaseManager {
  final _$ProfileDatabase _db;
  $ProfileDatabaseManager(this._db);
  $$ProfileEntityTableTableManager get profileEntity =>
      $$ProfileEntityTableTableManager(_db, _db.profileEntity);
}
