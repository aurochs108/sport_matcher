import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/ui/authentication/email_authentication/email_authentication_screen_model.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'email_authentication_screen_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator])
void main() {
  group('EmailAuthenticationScreenModel', () {
    late MockAbstractTextValidator emailValidator;
    late MockAbstractTextValidator passwordValidator;
    late String title;
    late int onStateChangedCallsCount;
    late EmailAuthenticationScreenModel sut;

    setUp(() {
      title = Uuid().v4();
      emailValidator = MockAbstractTextValidator();
      passwordValidator = MockAbstractTextValidator();
      sut = EmailAuthenticationScreenModel(
        title: title,
        emailValidator: emailValidator,
        passwordValidator: passwordValidator,
      );
      onStateChangedCallsCount = 0;
      sut.onStateChanged = () {
        onStateChangedCallsCount += 1;
      };
    });

    test('should activate button when both validators return null', () {
      when(emailValidator.validate(any)).thenReturn(null);
      when(passwordValidator.validate(any)).thenReturn(null);

      sut.emailTextController.text = Uuid().v4();
      sut.passwordTextController.text = Uuid().v4();

      expect(sut.isFinishProcesButtonActive, isTrue);
      expect(1, onStateChangedCallsCount);
    });

    test('should deactivate button when emailValidator returns error', () {
      // given
      when(emailValidator.validate("")).thenReturn(null);
      when(passwordValidator.validate(any)).thenReturn(null);

      final expectedEmail = Uuid().v4();
      final expectedErrorMessage = Uuid().v4();
      when(emailValidator.validate(expectedEmail))
          .thenReturn(expectedErrorMessage);

      // when
      sut.emailTextController.text = expectedEmail;
      final expectedPassword = Uuid().v4();
      sut.passwordTextController.text = expectedPassword;

      // then
      expect(sut.isFinishProcesButtonActive, isFalse);
      expect(onStateChangedCallsCount, 0);
      verify(passwordValidator.validate(captureAny)).called(2);

      verify(emailValidator.validate(captureAny)).called(2);
      final capturedEmails = verify(emailValidator.validate(any)).captured;
      expect(capturedEmails, ["", expectedEmail]);
    });

    test('should deactivate button when passwordValidator returns error', () {
      // given
      when(emailValidator.validate(any)).thenReturn(null);
      when(passwordValidator.validate("")).thenReturn(null);

      final expectedPassword = Uuid().v4();
      final expectedErrorMessage = Uuid().v4();
      when(passwordValidator.validate(expectedPassword))
          .thenReturn(expectedErrorMessage);

      // when
      sut.emailTextController.text = Uuid().v4();
      sut.passwordTextController.text = expectedPassword;

      // then
      expect(sut.isFinishProcesButtonActive, isFalse);
      expect(2, onStateChangedCallsCount);
    });
  });
}
