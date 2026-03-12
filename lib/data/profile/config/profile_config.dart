import 'package:sport_matcher/data/profile/config/activities_config.dart';

final class ProfileConfig {
  static const int nameMinLength = 2;
  static const int nameMaxLength = 100;

  static const List<ActivitiesConfig> activities = ActivitiesConfig.values;
}