import 'dart:math';

import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';
import 'package:uuid/uuid.dart';

class ProfileEntityDataRandom {
  static ProfileEntityData random() {
    final random = Random();

    return ProfileEntityData(
      id: 1,
      name: const Uuid().v4(),
      profileImagePath: _randomImagePath(random),
      bike: random.nextBool(),
      climbing: random.nextBool(),
      football: random.nextBool(),
      hockey: random.nextBool(),
      pingPong: random.nextBool(),
      running: random.nextBool(),
      tennis: random.nextBool(),
      voleyball: random.nextBool(),
    );
  }

  static String _randomImagePath(Random random) {
    return 'assets/images/profile_${random.nextInt(10)}.png';
  }
}
