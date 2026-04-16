import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_token_database.dart';
import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

class TokenDatabase implements AbstractTokenDatabase {
  static const _tokenKey = 'auth_tokens';

  final FlutterSecureStorage _storage;

  TokenDatabase({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> saveTokens(TokenEntity entity) async {
    await _storage.write(key: _tokenKey, value: jsonEncode(entity));
  }
}
