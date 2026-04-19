import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_token_database.dart';
import 'package:sport_matcher/data/auth/persistence/database/token_database.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';

class AuthRepository extends AbstractAuthRepository {
  final AbstractTokenDatabase _tokenDatabase;
  final AuthTokensMapper _mapper;

  AuthRepository({
    AbstractTokenDatabase? tokenDatabase,
    AuthTokensMapper? mapper,
  }) : _tokenDatabase = tokenDatabase ?? TokenDatabase(),
       _mapper = mapper ?? AuthTokensMapper();

  @override
  Future<void> saveTokens(AuthTokensDomain tokens) {
    return _tokenDatabase.saveTokens(_mapper.domainToEntity(tokens));
  }
}
