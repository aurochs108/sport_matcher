import 'package:sport_matcher/data/profile/domain/profile_domain.dart';

abstract class AbstractProfilesRepository {
  Future<void> addProfile(ProfileDomain profile);
}