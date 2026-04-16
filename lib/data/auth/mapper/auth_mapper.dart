import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/network/response/auth_response.dart';
import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

class AuthMapper {
  AuthTokensDomain responseToDomain(AuthResponse response) {
    return AuthTokensDomain(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      tokenType: response.tokenType,
      expiresIn: response.expiresIn,
    );
  }

  TokenEntity domainToEntity(AuthTokensDomain domain) {
    return TokenEntity(
      accessToken: domain.accessToken,
      refreshToken: domain.refreshToken,
      tokenType: domain.tokenType,
      expiresIn: domain.expiresIn,
    );
  }
}
