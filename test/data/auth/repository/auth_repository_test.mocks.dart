import 'dart:async' as _i1;

import 'package:mockito/mockito.dart' as _i2;
import 'package:sport_matcher/data/auth/domain/auth_tokens.dart' as _i3;
import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart' as _i4;
import 'package:sport_matcher/data/auth/persistence/database/abstract_auth_tokens_database.dart'
    as _i5;
import 'package:sport_matcher/data/auth/persistence/entity/auth_tokens_entity.dart'
    as _i6;

class MockAbstractAuthTokensDatabase extends _i2.Mock
    implements _i5.AbstractAuthTokensDatabase {
  @override
  _i1.Future<void> saveTokens(_i6.AuthTokensEntity? entity) =>
      (super.noSuchMethod(
            Invocation.method(#saveTokens, [entity]),
            returnValue: _i1.Future<void>.value(),
            returnValueForMissingStub: _i1.Future<void>.value(),
          )
          as _i1.Future<void>);
}

class MockAuthTokensMapper extends _i2.Mock implements _i4.AuthTokensMapper {
  @override
  _i6.AuthTokensEntity domainToEntity(_i3.AuthTokensDomain? domain) =>
      (super.noSuchMethod(
            Invocation.method(#domainToEntity, [domain]),
            returnValue: _i6.AuthTokensEntity(
              accessToken: '',
              refreshToken: '',
              tokenType: '',
              expiresIn: 0,
            ),
            returnValueForMissingStub: _i6.AuthTokensEntity(
              accessToken: '',
              refreshToken: '',
              tokenType: '',
              expiresIn: 0,
            ),
          )
          as _i6.AuthTokensEntity);
}
