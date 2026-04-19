import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/data/auth/persistence/database/auth_tokens_database.dart';
import 'package:sport_matcher/data/auth/persistence/entity/auth_tokens_entity.dart';
import '../../../../mocks/mock_flutter_secure_storage.dart';

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

      await sut.saveTokens(entity);

      expect(storage.capturedKey, 'auth_tokens');
      expect(storage.capturedValue, expectedJson);
    });

    test('saveTokens propagates storage errors', () async {
      final entity = AuthTokensEntity(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final exception = Exception('write failed');
      storage.writeError = exception;

      expect(
        sut.saveTokens(entity),
        throwsA(same(exception)),
      );
    });
  });
}
