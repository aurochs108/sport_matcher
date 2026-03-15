import 'package:sport_matcher/data/profile/config/activities_config.dart';

class ProfileDomain {
  final String name;
  final String profileImagePath;
  final Map<ActivitiesConfig, bool> activities;

  ProfileDomain({
    required this.name,
    required this.profileImagePath,
    required this.activities,
  });
}
