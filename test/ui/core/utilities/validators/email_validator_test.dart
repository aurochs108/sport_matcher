import 'package:sport_matcher/ui/core/utilities/validators/email_validator.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('EmailValidator', () {
    final sut = EmailValidator();

    test('should return error message when email is null', () {
      expect(sut.validate(null), "Cannot be empty");
    });

    test('should return error message when email is empty', () {
      expect(sut.validate(''), "Cannot be empty");
    });

    test('should return error message when email is invalid', () {
      final uuid = Uuid();
      final expectedErrorMessage = "Invalid email address";

      expect(sut.validate(uuid.v4()), expectedErrorMessage);
      expect(sut.validate('${uuid.v4()}@${uuid.v4()}'), expectedErrorMessage);
      expect(sut.validate('${uuid.v4()}.${uuid.v4()}@'), expectedErrorMessage);
      expect(sut.validate('${uuid.v4()}@.com'), expectedErrorMessage);
    });

    test('should return null when email is valid', () {
      final uuid = Uuid();

      expect(sut.validate('${uuid.v4()}@${uuid.v4()}.com'), null);
      expect(sut.validate('${uuid.v4()}.${uuid.v4()}@${uuid.v4()}.co'), null);
      expect(sut.validate('${uuid.v4()}+${uuid.v4()}@${uuid.v4()}.com'), null);
    });
  });
}