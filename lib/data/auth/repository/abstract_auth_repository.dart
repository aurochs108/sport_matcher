import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';

abstract class AbstractAuthRepository {
  Future<void> saveTokens(AuthTokensDomain tokens);
  Future<AuthTokensDomain?> loadTokens();
  Future<void> clearTokens();
}
