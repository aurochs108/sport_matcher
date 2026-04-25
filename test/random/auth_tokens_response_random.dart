import 'dart:math';

import 'package:sport_matcher/data/auth/network/response/auth_tokens_reponse.dart';
import 'package:uuid/uuid.dart';

class AuthTokensResponseRandom {
  static AuthTokensReponse random() {
    final random = Random();

    return AuthTokensReponse(
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
