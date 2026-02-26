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
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
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
  const ProfileEntityData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ProfileEntityCompanion toCompanion(bool nullToAbsent) {
    return ProfileEntityCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory ProfileEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileEntityData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ProfileEntityData copyWith({int? id, String? name}) => ProfileEntityData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  ProfileEntityData copyWithCompanion(ProfileEntityCompanion data) {
    return ProfileEntityData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEntityData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileEntityData &&
          other.id == this.id &&
          other.name == this.name);
}

class ProfileEntityCompanion extends UpdateCompanion<ProfileEntityData> {
  final Value<int> id;
  final Value<String> name;
  const ProfileEntityCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ProfileEntityCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<ProfileEntityData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ProfileEntityCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ProfileEntityCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileEntityCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
});
typedef $$ProfileEntityTableUpdateCompanionBuilder = ProfileEntityCompanion
    Function({
  Value<int> id,
  Value<String> name,
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
          }) =>
              ProfileEntityCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              ProfileEntityCompanion.insert(
            id: id,
            name: name,
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
