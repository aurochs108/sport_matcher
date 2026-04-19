import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_auth_tokens_database.dart';
import 'package:sport_matcher/data/auth/persistence/entity/auth_tokens_entity.dart';

class AuthTokensDatabase implements AbstractAuthTokensDatabase {
  static const _tokenKey = 'auth_tokens';

  final FlutterSecureStorage _storage;

  AuthTokensDatabase({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> saveTokens(AuthTokensEntity entity) async {
    await _storage.write(key: _tokenKey, value: jsonEncode(entity));
  }
}
