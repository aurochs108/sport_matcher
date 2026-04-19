import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart';
import 'package:sport_matcher/data/auth/network/response/auth_response.dart';

void main() {
  group('AuthTokensMapper', () {
    final sut = AuthTokensMapper();

    test('responseToDomain maps response fields to domain', () {
      final response = AuthResponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );

      final result = sut.responseToDomain(response);

      expect(result.accessToken, response.accessToken);
      expect(result.refreshToken, response.refreshToken);
      expect(result.tokenType, response.tokenType);
      expect(result.expiresIn, response.expiresIn);
    });

    test('domainToEntity maps domain fields to entity', () {
      final domain = AuthTokensDomain(
        accessToken: 'domain-access-token',
        refreshToken: 'domain-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 7200,
      );

      final result = sut.domainToEntity(domain);

      expect(result.accessToken, domain.accessToken);
      expect(result.refreshToken, domain.refreshToken);
      expect(result.tokenType, domain.tokenType);
      expect(result.expiresIn, domain.expiresIn);
    });
  });
}
