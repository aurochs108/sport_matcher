import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/widgets/email_authentication_screen_model.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'email_authentication_screen_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator])
void main() {
  group('EmailAuthenticationScreenModel', () {
    late String title;
    late MockAbstractTextValidator emailValidator;
    late MockAbstractTextValidator passwordValidator;
    late int onFinishProcessButtonActionCallsCount;
    late int onStateChangedCallsCount;
    late EmailAuthenticationScreenModel sut;

    setUp(() {
      title = Uuid().v4();
      emailValidator = MockAbstractTextValidator();
      passwordValidator = MockAbstractTextValidator();
      onFinishProcessButtonActionCallsCount = 0;
      sut = EmailAuthenticationScreenModel(
        title: title,
        emailValidator: emailValidator,
        passwordValidator: passwordValidator,
        onFinishProcessButtonAction: () =>
            {onFinishProcessButtonActionCallsCount += 1},
      );
      onStateChangedCallsCount = 0;
      sut.onStateChanged = () {
        onStateChangedCallsCount += 1;
      };
    });

    // MARK: - button activation

    test('should activate button when both validators return null', () {
      // given
      final noTextError = Uuid().v4();
      when(emailValidator.validate("")).thenReturn(noTextError);
      when(passwordValidator.validate("")).thenReturn(noTextError);

      final expectedEmail = Uuid().v4();
      when(emailValidator.validate(expectedEmail)).thenReturn(null);
      final expectedPassword = Uuid().v4();
      when(passwordValidator.validate(expectedPassword)).thenReturn(null);

      // when
      sut.emailTextController.text = expectedEmail;
      sut.passwordTextController.text = expectedPassword;

      // then
      _validateEmailAndPasswordValidatorsAndIsFinishProcessButtonActive(
        sut: sut,
        expectedIsFinishProcesButtonActive: isTrue,
        onStateChangedCallsCount: onStateChangedCallsCount,
        expectedOnStateChangedCallsCount: 1,
        emailValidator: emailValidator,
        expectedValidatedEmails: [expectedEmail, expectedEmail],
        passwordValidator: passwordValidator,
        expectedValidatedPasswords: ["", expectedPassword],
      );
    });

    test('should deactivate button when emailValidator returns error', () {
      // given
      final noTextError = Uuid().v4();
      when(emailValidator.validate("")).thenReturn(noTextError);
      when(passwordValidator.validate("")).thenReturn(noTextError);

      final expectedEmail = Uuid().v4();
      final expectedErrorMessage = Uuid().v4();
      when(emailValidator.validate(expectedEmail))
          .thenReturn(expectedErrorMessage);

      // when
      sut.emailTextController.text = expectedEmail;

      // then
      _validateEmailAndPasswordValidatorsAndIsFinishProcessButtonActive(
        sut: sut,
        expectedIsFinishProcesButtonActive: isFalse,
        onStateChangedCallsCount: onStateChangedCallsCount,
        expectedOnStateChangedCallsCount: 0,
        emailValidator: emailValidator,
        expectedValidatedEmails: [expectedEmail],
        passwordValidator: passwordValidator,
        expectedValidatedPasswords: [""],
      );
    });

    test('should deactivate button when passwordValidator returns error', () {
      // given
      final noTextError = Uuid().v4();
      when(emailValidator.validate("")).thenReturn(noTextError);
      when(passwordValidator.validate("")).thenReturn(noTextError);

      final expectedPassword = Uuid().v4();
      final expectedErrorMessage = Uuid().v4();
      when(passwordValidator.validate(expectedPassword))
          .thenReturn(expectedErrorMessage);

      // when
      sut.passwordTextController.text = expectedPassword;

      // then
      _validateEmailAndPasswordValidatorsAndIsFinishProcessButtonActive(
        sut: sut,
        expectedIsFinishProcesButtonActive: isFalse,
        onStateChangedCallsCount: onStateChangedCallsCount,
        expectedOnStateChangedCallsCount: 0,
        emailValidator: emailValidator,
        expectedValidatedEmails: [""],
        passwordValidator: passwordValidator,
        expectedValidatedPasswords: [expectedPassword],
      );
    });

    // MARK: - getFinishProcessButtonAction

    test('should returns null when button is not active', () {
      // when
      final onFinishProcessButtonAction = sut.getFinishProcessButtonAction();
      onFinishProcessButtonAction?.call();

      // then
      expect(onFinishProcessButtonAction, isNull);
      expect(onFinishProcessButtonActionCallsCount, 0);
    });

    test(
        'should execute onFinishProcessButtonActionCallsCount when button is active',
        () {
      // given
      final noTextError = Uuid().v4();
      when(emailValidator.validate("")).thenReturn(noTextError);
      when(passwordValidator.validate("")).thenReturn(noTextError);

      final expectedEmail = Uuid().v4();
      when(emailValidator.validate(expectedEmail)).thenReturn(null);
      final expectedPassword = Uuid().v4();
      when(passwordValidator.validate(expectedPassword)).thenReturn(null);

      sut.emailTextController.text = expectedEmail;
      sut.passwordTextController.text = expectedPassword;

      // when
      final onFinishProcessButtonAction = sut.getFinishProcessButtonAction();
      onFinishProcessButtonAction?.call();

      // then
      expect(onFinishProcessButtonAction, isNotNull);
      expect(onFinishProcessButtonActionCallsCount, 1);
    });
  });
}

void _validateEmailAndPasswordValidatorsAndIsFinishProcessButtonActive({
  required EmailAuthenticationScreenModel sut,
  required Matcher expectedIsFinishProcesButtonActive,
  required int onStateChangedCallsCount,
  required int expectedOnStateChangedCallsCount,
  required MockAbstractTextValidator emailValidator,
  required List<String> expectedValidatedEmails,
  required MockAbstractTextValidator passwordValidator,
  required List<String> expectedValidatedPasswords,
}) {
  expect(sut.isFinishProcesButtonActive, expectedIsFinishProcesButtonActive);
  expect(onStateChangedCallsCount, expectedOnStateChangedCallsCount);

  final capturedEmails = verify(emailValidator.validate(captureAny)).captured;
  expect(capturedEmails, expectedValidatedEmails);

  final capturedPasswords =
      verify(passwordValidator.validate(captureAny)).captured;
  expect(capturedPasswords, expectedValidatedPasswords);
}
