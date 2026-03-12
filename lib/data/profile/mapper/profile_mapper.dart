import 'package:drift/drift.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';

class ProfileMapper {
  ProfileEntityCompanion toEntity(ProfileDomain domain) {
    return ProfileEntityCompanion(
      name: Value(domain.name),
      profileImagePath: Value(domain.profileImagePath),
      bike: Value(_isSelected(domain.activities, ActivitiesConfig.bike)),
      climbing:
          Value(_isSelected(domain.activities, ActivitiesConfig.climbing)),
      football:
          Value(_isSelected(domain.activities, ActivitiesConfig.football)),
      hockey: Value(_isSelected(domain.activities, ActivitiesConfig.hockey)),
      pingPong:
          Value(_isSelected(domain.activities, ActivitiesConfig.pingPong)),
      running: Value(_isSelected(domain.activities, ActivitiesConfig.running)),
      tennis: Value(_isSelected(domain.activities, ActivitiesConfig.tennis)),
      voleyball:
          Value(_isSelected(domain.activities, ActivitiesConfig.voleyball)),
    );
  }

  ProfileDomain toDomain(ProfileEntityData entity) {
    return ProfileDomain(
      name: entity.name,
      profileImagePath: entity.profileImagePath,
      activities: {
        for (final activity in ProfileConfig.activities)
          activity: _toSelectionMap(entity, activity),
      },
    );
  }

  bool _isSelected(
      Map<ActivitiesConfig, bool> activities, ActivitiesConfig activity) {
    return activities[activity] ?? false;
  }

  bool _toSelectionMap(ProfileEntityData entity, ActivitiesConfig activity) {
    switch (activity) {
      case ActivitiesConfig.bike:
        return entity.bike;
      case ActivitiesConfig.climbing:
        return entity.climbing;
      case ActivitiesConfig.football:
        return entity.football;
      case ActivitiesConfig.hockey:
        return entity.hockey;
      case ActivitiesConfig.pingPong:
        return entity.pingPong;
      case ActivitiesConfig.running:
        return entity.running;
      case ActivitiesConfig.tennis:
        return entity.tennis;
      case ActivitiesConfig.voleyball:
        return entity.voleyball;
    }
  }
}
