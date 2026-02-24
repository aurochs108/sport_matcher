import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/mapper/profile_mapper.dart';
import 'package:sport_matcher/data/profile/persistence/database/abstract_profile_database.dart';
import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';

class ProfilesRepository extends AbstractProfilesRepository {
  final AbstractProfileDatabase _profileDatabase;
  final ProfileMapper _mapper;

  ProfilesRepository(
      {AbstractProfileDatabase? profileDatabase, ProfileMapper? mapper})
      : _profileDatabase = profileDatabase ?? ProfileDatabase(),
        _mapper = mapper ?? ProfileMapper();

  @override
  Future<void> addProfile(ProfileDomain profile) {
    final profileEntity = _mapper.toEntity(profile);
    return _profileDatabase.insertProfile(profileEntity);
  }

  @override
  Future<ProfileDomain?> loadProfile() async {
    final profileEntity = await _profileDatabase.loadProfile();
    return profileEntity == null ? null : _mapper.toDomain(profileEntity);
  }
}
