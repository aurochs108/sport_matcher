import 'package:drift/drift.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';

class ProfileMapper {
  ProfileEntityCompanion toEntity(ProfileDomain domain) {
    return ProfileEntityCompanion(name: Value(domain.name));
  }
}