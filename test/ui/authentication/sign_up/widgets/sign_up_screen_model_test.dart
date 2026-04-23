import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen_model.dart';

class MockAbstractAuthRepository extends Mock implements AbstractAuthRepository {}

void main() {
  group('SignUpScreenModel', () {
    late MockAbstractAuthRepository authRepository;
    late SignUpScreenModel sut;

    setUp(() {
      authRepository = MockAbstractAuthRepository();
      sut = SignUpScreenModel(
        authRepository: authRepository,
      );
    });

    test('register calls repository and clears previous error on success', () async {
      when(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).thenAnswer((_) async => ApiSuccess<void>(null));
      sut.errorMessage = 'previous error';

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, isNull);
      verify(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).called(1);
    });

    test('register stores repository error message on generic error', () async {
      when(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).thenAnswer((_) async => const ApiError('Registration failed', statusCode: 500));

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, 'Registration failed');
    });

    test('register maps EMAIL_ALREADY_REGISTERED to the user-friendly message', () async {
      when(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).thenAnswer(
        (_) async => const ApiError<void>(
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
    });

    test('register clears previous error before a successful retry', () async {
      when(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).thenAnswer((_) async => const ApiError('Initial failure', statusCode: 500));

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, 'Initial failure');
      when(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).thenAnswer((_) async => ApiSuccess<void>(null));

      await sut.register('user@example.com', 'strong-password');

      expect(sut.errorMessage, isNull);
      verify(
        authRepository.registerWithEmail(
          email: 'user@example.com',
          password: 'strong-password',
        ),
      ).called(2);
    });
  });
}
