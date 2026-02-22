import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_matcher/data/database/profile/table/profiles_table.dart';

part 'profile_database.g.dart';

@DriftDatabase(tables: [ProfilesTable])
class ProfileDatabase extends _$ProfileDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  ProfileDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertProfile(String name) async {
    return await into(profilesTable).insert(ProfilesTableCompanion.insert(name: name));
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