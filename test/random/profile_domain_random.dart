import 'dart:math';

import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:uuid/uuid.dart';

class ProfileDomainRandom {
  static ProfileDomain random() {
    final random =  Random();

    return ProfileDomain(
      name: const Uuid().v4(),
      profileImagePath: _randomImagePath(random),
      activities: Map<ActivitiesConfig, bool>.fromEntries(
        ActivitiesConfig.values
            .map((activity) => MapEntry(activity, random.nextBool())),
      ),
    );
  }

  static String _randomImagePath(Random random) {
    return 'assets/images/profile_${random.nextInt(10)}.png';
  }
}
