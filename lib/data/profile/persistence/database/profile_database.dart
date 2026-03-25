import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_matcher/data/profile/persistence/entity/profile_entity.dart';
import 'abstract_profile_database.dart';

part 'profile_database.g.dart';

@DriftDatabase(tables: [ProfileEntity])
class ProfileDatabase extends _$ProfileDatabase
    implements AbstractProfileDatabase {
  static final ProfileDatabase _singleton = ProfileDatabase._internal();

  factory ProfileDatabase({QueryExecutor? executor}) {
    if (executor != null) {
      return ProfileDatabase._withExecutor(executor);
    }

    return _singleton;
  }

  ProfileDatabase._internal() : super(_openConnection());

  ProfileDatabase._withExecutor(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  Future<int> insertProfile(ProfileEntityCompanion profile) async {
    final singletonProfile = ProfileEntityCompanion(
      id: const Value(1),
      name: profile.name,
      profileImagePath: profile.profileImagePath,
      bike: profile.bike,
      climbing: profile.climbing,
      football: profile.football,
      hockey: profile.hockey,
      pingPong: profile.pingPong,
      running: profile.running,
      tennis: profile.tennis,
      voleyball: profile.voleyball,
    );

    return await into(profileEntity).insertOnConflictUpdate(singletonProfile);
  }

  @override
  Future<ProfileEntityData?> loadProfile() async {
    return await select(profileEntity).getSingleOrNull();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'profile_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
