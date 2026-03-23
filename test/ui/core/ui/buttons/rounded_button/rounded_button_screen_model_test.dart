import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button/rounded_button_screen_model.dart';

void main() {
  group('RoundedButtonScreenModel', () {
    // MARK: - onPressedAction

    test('onPressedAction returns callback when onPressed is provided', () {
      // given
      var callCount = 0;
      final sut = RoundedButtonScreenModel(onPressed: () => callCount++);

      // when
      sut.onPressedAction?.call();

      // then
      expect(sut.onPressedAction, isNotNull);
      expect(callCount, 1);
    });

    test('onPressedAction returns null when onPressed is not provided', () {
      // given
      final sut = RoundedButtonScreenModel();

      // then
      expect(sut.onPressedAction, isNull);
    });

    // MARK: - backgroundColor

    test('backgroundColor returns blue when onPressed is provided', () {
      // given
      final sut = RoundedButtonScreenModel(onPressed: () {});

      // then
      expect(sut.backgroundColor, Colors.blue);
    });

    test('backgroundColor returns grey when onPressed is not provided', () {
      // given
      final sut = RoundedButtonScreenModel();

      // then
      expect(sut.backgroundColor, Colors.grey);
    });
  });
}
