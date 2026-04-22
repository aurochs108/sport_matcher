import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/auth/domain/auth_tokens.dart';
import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart';
import 'package:sport_matcher/data/auth/network/api/auth_api.dart';
import 'package:sport_matcher/data/auth/network/response/auth_tokens_reponse.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/device_id/repository/abstract_device_id_repository.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen_model.dart';

import 'sign_up_screen_model_test.mocks.dart';

@GenerateMocks([
  AuthApi,
  AbstractDeviceIdRepository,
  AbstractAuthRepository,
  AuthTokensMapper,
])
void main() {
  provideDummy<ApiResult<AuthTokensReponse>>(
    const ApiError<AuthTokensReponse>('dummy error'),
  );

  group('SignUpScreenModel', () {
    late MockAuthApi authApi;
    late MockAbstractDeviceIdRepository deviceIdRepository;
    late MockAbstractAuthRepository authRepository;
    late MockAuthTokensMapper authTokensMapper;
    late SignUpScreenModel sut;

    setUp(() {
      authApi = MockAuthApi();
      deviceIdRepository = MockAbstractDeviceIdRepository();
      authRepository = MockAbstractAuthRepository();
      authTokensMapper = MockAuthTokensMapper();
      sut = SignUpScreenModel(
        authApi: authApi,
        deviceIdRepository: deviceIdRepository,
        authRepository: authRepository,
        authTokensMapper: authTokensMapper,
      );
    });

    test('register gets device ID, calls API, maps tokens, and saves them', () async {
      final response = AuthTokensReponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final mappedTokens = AuthTokensDomain(
        accessToken: 'mapped-access-token',
        refreshToken: 'mapped-refresh-token',
        tokenType: 'MappedBearer',
        expiresIn: 7200,
      );
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => ApiSuccess(response));
      when(authTokensMapper.responseToDomain(response)).thenReturn(mappedTokens);
      when(authRepository.saveTokens(mappedTokens)).thenAnswer((_) async {});
      sut.errorMessage = 'previous error';

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, isNull);
      verify(deviceIdRepository.getDeviceId()).called(1);
      verify(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).called(1);
      verify(authTokensMapper.responseToDomain(response)).called(1);
      verify(authRepository.saveTokens(mappedTokens)).called(1);
    });

    test('register stores API error message and does not save tokens on generic error', () async {
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => const ApiError('Registration failed', statusCode: 500));

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, 'Registration failed');
      verify(deviceIdRepository.getDeviceId()).called(1);
      verifyZeroInteractions(authTokensMapper);
      verifyZeroInteractions(authRepository);
    });

    test('register maps EMAIL_ALREADY_REGISTERED to the user-friendly message', () async {
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer(
        (_) async => const ApiError(
          'Backend duplicate message',
          statusCode: 409,
          code: 'EMAIL_ALREADY_REGISTERED',
        ),
      );

      await sut.register('user@example.com', 'strong-password');

      expect(
        sut.errorMessage,
        'This email is already in use. Please use a different email.',
      );
      verifyZeroInteractions(authTokensMapper);
      verifyZeroInteractions(authRepository);
    });

    test('register clears previous error before a successful retry', () async {
      final response = AuthTokensReponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      final mappedTokens = AuthTokensDomain(
        accessToken: 'mapped-access-token',
        refreshToken: 'mapped-refresh-token',
        tokenType: 'Bearer',
        expiresIn: 3600,
      );
      when(deviceIdRepository.getDeviceId()).thenAnswer((_) async => 'device-id');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => const ApiError('Initial failure', statusCode: 500));

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, 'Initial failure');
      when(
        authApi.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
          deviceId: 'device-id',
        ),
      ).thenAnswer((_) async => ApiSuccess(response));
      when(authTokensMapper.responseToDomain(response)).thenReturn(mappedTokens);
      when(authRepository.saveTokens(mappedTokens)).thenAnswer((_) async {});

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, isNull);
      verify(deviceIdRepository.getDeviceId()).called(2);
      verify(authRepository.saveTokens(mappedTokens)).called(1);
    });
  });
}
