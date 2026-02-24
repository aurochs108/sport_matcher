import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';

abstract class AbstractProfileDatabase {
  Future<int> insertProfile(ProfileEntityCompanion profile);
  Future<ProfileEntityData?> loadProfile();
}
