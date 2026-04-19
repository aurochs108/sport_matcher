import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/persistence/entity/auth_tokens_entity.dart';
import 'package:sport_matcher/data/auth/repository/auth_repository.dart';

import 'auth_repository_test.mocks.dart';

void main() {
  group('AuthRepository', () {
    late MockAbstractAuthTokensDatabase tokenDatabase;
    late MockAuthTokensMapper mapper;
    late AuthRepository sut;

    setUp(() {
      tokenDatabase = MockAbstractAuthTokensDatabase();
      mapper = MockAuthTokensMapper();
      sut = AuthRepository(
        tokenDatabase: tokenDatabase,
        mapper: mapper,
      );
    });

    test('saveTokens maps domain and saves mapped entity', () async {
      final tokens = AuthTokensDomain(
        accessToken: 'domain-access-token',
        refreshToken: 'domain-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 7200,
      );
      final mappedEntity = AuthTokensEntity(
        accessToken: 'mapped-access-token',
        refreshToken: 'mapped-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      when(mapper.domainToEntity(tokens)).thenReturn(mappedEntity);
      when(tokenDatabase.saveTokens(mappedEntity)).thenAnswer((_) async {});

      await sut.saveTokens(tokens);

      verify(mapper.domainToEntity(tokens)).called(1);
      verify(tokenDatabase.saveTokens(mappedEntity)).called(1);
    });

    test('saveTokens propagates database errors', () async {
      final tokens = AuthTokensDomain(
        accessToken: 'domain-access-token',
        refreshToken: 'domain-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 7200,
      );
      final mappedEntity = AuthTokensEntity(
        accessToken: 'mapped-access-token',
        refreshToken: 'mapped-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final exception = Exception('save failed');
      when(mapper.domainToEntity(tokens)).thenReturn(mappedEntity);
      when(
        tokenDatabase.saveTokens(mappedEntity),
      ).thenAnswer((_) => Future<void>.error(exception));

      expect(
        sut.saveTokens(tokens),
        throwsA(same(exception)),
      );
    });
  });
}
