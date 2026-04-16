import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

abstract class AbstractTokenDatabase {
  Future<void> saveTokens(TokenEntity entity);
}
