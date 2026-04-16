import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';

abstract class AbstractAuthRepository {
  Future<void> saveTokens(AuthTokensDomain tokens);
}
