import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_token_storage.dart';
import 'package:sport_matcher/data/auth/persistence/entity/token_entity.dart';

class TokenStorage implements AbstractTokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> saveTokens(TokenEntity entity) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: entity.accessToken),
      _storage.write(key: _refreshTokenKey, value: entity.refreshToken),
    ]);
  }

  @override
  Future<TokenEntity?> loadTokens() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    if (accessToken == null || refreshToken == null) return null;

    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }
}
