import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/network/response/auth_response.dart';
import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

class AuthMapper {
  AuthTokens responseToDomain(AuthResponse response) {
    return AuthTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      tokenType: response.tokenType,
      expiresIn: response.expiresIn,
    );
  }

  TokenEntity toEntity(AuthTokens domain) {
    return TokenEntity(
      accessToken: domain.accessToken,
      refreshToken: domain.refreshToken,
    );
  }

  AuthTokens entityToDomain(TokenEntity entity) {
    return AuthTokens(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      tokenType: 'Bearer',
      expiresIn: 0,
    );
  }
}
