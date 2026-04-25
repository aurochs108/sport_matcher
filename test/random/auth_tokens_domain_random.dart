import 'dart:math';

import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:uuid/uuid.dart';

class AuthTokensDomainRandom {
  static AuthTokensDomain random() {
    final random = Random();

    return AuthTokensDomain(
      accessToken: const Uuid().v4(),
      refreshToken: const Uuid().v4(),
      tokenType: _randomTokenType(random),
      expiresIn: random.nextInt(86400) + 1,
    );
  }

  static String _randomTokenType(Random random) {
    return ['Bearer', 'Token'][random.nextInt(2)];
  }
}
