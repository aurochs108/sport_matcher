import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/auth/persistence/database/auth_tokens_database.dart';
import 'package:sport_matcher/data/auth/persistence/entity/auth_tokens_entity.dart';

import 'auth_tokens_database_test.mocks.dart';

void main() {
  group('AuthTokensDatabase', () {
    late MockFlutterSecureStorage storage;
    late AuthTokensDatabase sut;

    setUp(() {
      storage = MockFlutterSecureStorage();
      sut = AuthTokensDatabase(storage: storage);
    });

    test('saveTokens writes entity json under auth_tokens key', () async {
      final entity = AuthTokensEntity(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final expectedJson = jsonEncode(entity);
      when(
        storage.write(
          key: 'auth_tokens',
          value: expectedJson,
        ),
      ).thenAnswer((_) async {});

      await sut.saveTokens(entity);

      verify(
        storage.write(
          key: 'auth_tokens',
          value: expectedJson,
        ),
      ).called(1);
    });

    test('saveTokens propagates storage errors', () async {
      final entity = AuthTokensEntity(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final expectedJson = jsonEncode(entity);
      final exception = Exception('write failed');
      when(
        storage.write(
          key: 'auth_tokens',
          value: expectedJson,
        ),
      ).thenAnswer((_) => Future<void>.error(exception));

      expect(
        sut.saveTokens(entity),
        throwsA(same(exception)),
      );
    });
  });
}
