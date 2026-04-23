import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart';
import 'package:sport_matcher/data/auth/network/api/abstract_auth_api.dart';
import 'package:sport_matcher/data/auth/network/response/auth_tokens_reponse.dart';
import 'package:sport_matcher/data/auth/persistence/database/abstract_auth_tokens_database.dart';
import 'package:sport_matcher/data/auth/repository/auth_repository.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/core/mapper/abstract_api_error_to_user_message_mapper.dart';
import 'package:sport_matcher/data/device_id/repository/abstract_device_id_repository.dart';

import '../../../random/auth_tokens_domain_random.dart';
import '../../../random/auth_tokens_entity_random.dart';
import '../../../random/auth_tokens_response_random.dart';
import 'auth_repository_test.mocks.dart';

@GenerateMocks([
  AbstractAuthApi,
  AbstractDeviceIdRepository,
  AbstractAuthTokensDatabase,
  AuthTokensMapper,
  AbstractApiErrorToUserMessageMapper,
])
void main() {
  provideDummy<ApiResult<AuthTokensReponse>>(
    const ApiError<AuthTokensReponse>('dummy error'),
  );

  group('AuthRepository', () {
    late MockAbstractAuthApi authApi;
    late MockAbstractDeviceIdRepository deviceIdRepository;
    late MockAbstractAuthTokensDatabase tokenDatabase;
    late MockAuthTokensMapper mapper;
    late MockAbstractApiErrorToUserMessageMapper errorMapper;
    late AuthRepository sut;

    setUp(() {
      authApi = MockAbstractAuthApi();
      deviceIdRepository = MockAbstractDeviceIdRepository();
      tokenDatabase = MockAbstractAuthTokensDatabase();
      mapper = MockAuthTokensMapper();
      errorMapper = MockAbstractApiErrorToUserMessageMapper();
      sut = AuthRepository(
        authApi: authApi,
        deviceIdRepository: deviceIdRepository,
        tokenDatabase: tokenDatabase,
        mapper: mapper,
        errorMapper: errorMapper,
      );
    });

    test('registerWithEmail gets device ID, calls API, saves tokens, and returns success', () async {
      final response = AuthTokensResponseRandom.random();
      final mappedTokens = AuthTokensDomainRandom.random();
      final mappedEntity = AuthTokensEntityRandom.random();
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => ApiSuccess(response));
      when(mapper.responseToDomain(response)).thenReturn(mappedTokens);
      when(mapper.domainToEntity(mappedTokens)).thenReturn(mappedEntity);
      when(tokenDatabase.saveTokens(mappedEntity)).thenAnswer((_) async {});

      final result = await sut.registerWithEmail(
        email: 'user@example.com',
        password: 'strong-password',
      );

      expect(result, isA<ApiSuccess<void>>());
      verify(deviceIdRepository.getDeviceId()).called(1);
      verify(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).called(1);
      verify(mapper.responseToDomain(response)).called(1);
      verify(mapper.domainToEntity(mappedTokens)).called(1);
      verify(tokenDatabase.saveTokens(mappedEntity)).called(1);
      verifyZeroInteractions(errorMapper);
    });

    test('registerWithEmail returns API error without saving tokens', () async {
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer(
        (_) async => const ApiError<AuthTokensReponse>(
          'Registration failed',
          statusCode: 409,
          code: 'EMAIL_ALREADY_REGISTERED',
        ),
      );

      final result = await sut.registerWithEmail(
        email: 'user@example.com',
        password: 'strong-password',
      );

      expect(result, isA<ApiError<void>>());
      expect((result as ApiError<void>).message, 'Registration failed');
      expect(result.statusCode, 409);
      expect(result.code, 'EMAIL_ALREADY_REGISTERED');
      verify(deviceIdRepository.getDeviceId()).called(1);
      verify(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).called(1);
      verifyZeroInteractions(mapper);
      verifyZeroInteractions(tokenDatabase);
      verifyZeroInteractions(errorMapper);
    });

    test('registerWithEmail maps device ID errors to ApiError', () async {
      final exception = Exception('device id failed');
      when(deviceIdRepository.getDeviceId()).thenAnswer(
        (_) => Future<String>.error(exception),
      );
      when(errorMapper.map(exception)).thenReturn('mapped error');

      final result = await sut.registerWithEmail(
        email: 'user@example.com',
        password: 'strong-password',
      );

      expect(result, isA<ApiError<void>>());
      expect((result as ApiError<void>).message, 'mapped error');
      expect(result.statusCode, isNull);
      expect(result.code, isNull);
      verify(errorMapper.map(same(exception))).called(1);
      verifyZeroInteractions(authApi);
      verifyZeroInteractions(tokenDatabase);
    });

    test('registerWithEmail maps token persistence errors to ApiError', () async {
      final response = AuthTokensResponseRandom.random();
      final mappedTokens = AuthTokensDomainRandom.random();
      final mappedEntity = AuthTokensEntityRandom.random();
      final exception = Exception('save failed');
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => ApiSuccess(response));
      when(mapper.responseToDomain(response)).thenReturn(mappedTokens);
      when(mapper.domainToEntity(mappedTokens)).thenReturn(mappedEntity);
      when(
        tokenDatabase.saveTokens(mappedEntity),
      ).thenAnswer((_) => Future<void>.error(exception));
      when(errorMapper.map(exception)).thenReturn('mapped error');

      final result = await sut.registerWithEmail(
        email: 'user@example.com',
        password: 'strong-password',
      );

      expect(result, isA<ApiError<void>>());
      expect((result as ApiError<void>).message, 'mapped error');
      expect(result.statusCode, isNull);
      expect(result.code, isNull);
      verify(errorMapper.map(same(exception))).called(1);
    });
  });
}
