import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/utilities/validators/minimum_text_length_validator.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

void main() {
  group('MinimumTextLengthValidator', () {
    final random = Random();
    final minimumLength = random.nextInt(10) + 2;
    final validator = MinimumTextLengthValidator(minimumLength: minimumLength);


    test('should return error message when text is null', () {
      expect(validator.validate(null), "Cannot be empty");
    });

    test('should return error message when text is empty', () {
      expect(validator.validate(''), "Cannot be empty");
    });

    test('should return error message when text is shorter than the minimum length', () {
      final uuid = Uuid();
      final numberToSubstract = max(random.nextInt(minimumLength) - 1, 1);
      final text = uuid.v4().characters.take(minimumLength - numberToSubstract).string;

      expect(validator.validate(text), "Cannot be less than $minimumLength characters");
    });

    test('should return error message when text length equals minimum length', () {
      final uuid = Uuid();
      final text = uuid.v4().characters.take(minimumLength).string;

      expect(validator.validate(text), "Cannot be less than $minimumLength characters");
    });

    test('should return null when text meets the minimum length', () {
      final uuid = Uuid();
      final text = uuid.v4().characters.take(minimumLength + 1).string;
  
      expect(validator.validate(text), null);
    });

    test('should return null when text is longer than the minimum length', () {
      final uuid = Uuid();
      final numberToAdd = random.nextInt(5) + 2;
      final text = uuid.v4().characters.take(minimumLength + numberToAdd).string;

      expect(validator.validate(text), null);
    });
  });
}