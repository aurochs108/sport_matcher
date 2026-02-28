import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

void main() {
  group('TextLengthValidator', () {
    final random = Random();
    final minimumLength = random.nextInt(10) + 2;
    final maximumLength = minimumLength + 10;
    final sut = TextLengthValidator(minimumLength: minimumLength, maximumLength: maximumLength);


    test('should return error message when text is null', () {
      expect(sut.validate(null), "Cannot be empty");
    });

    test('should return error message when text is empty', () {
      expect(sut.validate(''), "Cannot be empty");
    });

    test('should return error message when text is shorter than the minimum length', () {
      final uuid = Uuid();
      final numberToSubstract = max(random.nextInt(minimumLength) - 1, 1);
      final text = uuid.v4().characters.take(minimumLength - numberToSubstract).string;

      expect(sut.validate(text), "Cannot be less than $minimumLength characters");
    });

    final textLengths = <int>[minimumLength, maximumLength];
    for (final textLength in textLengths) {
      test('should return null when text length is $textLength characters long', () {
        final uuid = Uuid();
        final text = uuid.v4().characters.take(textLength).string;

        expect(sut.validate(text), null);
      });
    }

    test('should return error message when text is longer than maximum length', () {
      final uuid = Uuid();
      final text = uuid.v4().characters.take(maximumLength + 1).string;

      expect(
        sut.validate(text),
        "Cannot be more than $maximumLength characters",
      );
    });
  });
}