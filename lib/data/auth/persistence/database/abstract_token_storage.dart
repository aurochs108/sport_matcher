import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

abstract class AbstractTokenStorage {
  Future<void> saveTokens(TokenEntity entity);
  Future<TokenEntity?> loadTokens();
  Future<void> clearTokens();
}
