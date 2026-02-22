import 'package:sport_matcher/data/database/profile/database/profile_database.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';

class ProfilesRepository extends AbstractProfilesRepository {
  final _profileDatabase = ProfileDatabase();

  Future<void> addProfile(String name) {
    return _profileDatabase.insertProfile(name);
  }
}