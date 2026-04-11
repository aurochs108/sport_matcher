import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/mapper/auth_mapper.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_token_storage.dart';
import 'package:sport_matcher/data/auth/persistence/database/token_storage.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';

class AuthRepository extends AbstractAuthRepository {
  final AbstractTokenStorage _tokenStorage;
  final AuthMapper _mapper;

  AuthRepository({
    AbstractTokenStorage? tokenStorage,
    AuthMapper? mapper,
  })  : _tokenStorage = tokenStorage ?? TokenStorage(),
        _mapper = mapper ?? AuthMapper();

  @override
  Future<void> saveTokens(AuthTokens tokens) {
    return _tokenStorage.saveTokens(_mapper.toEntity(tokens));
  }

  @override
  Future<AuthTokens?> loadTokens() async {
    final entity = await _tokenStorage.loadTokens();
    if (entity == null) return null;

    return _mapper.entityToDomain(entity);
  }

  @override
  Future<void> clearTokens() {
    return _tokenStorage.clearTokens();
  }
}
