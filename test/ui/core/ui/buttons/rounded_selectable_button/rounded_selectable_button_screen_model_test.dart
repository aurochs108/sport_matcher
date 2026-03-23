import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_selectable_button/rounded_selectable_button_screen_model.dart';

void main() {
  group('RoundedSelectableButtonScreenModel', () {
    // MARK: - isSelected

    test('isSelected returns false by default', () {
      // given
      final sut = RoundedSelectableButtonScreenModel();

      // then
      expect(sut.isSelected, false);
    });

    test('isSelected returns true when initiallySelected is true', () {
      // given
      final sut = RoundedSelectableButtonScreenModel(initiallySelected: true);

      // then
      expect(sut.isSelected, true);
    });

    // MARK: - onPressedAction

    test('onPressedAction returns null when onSelectionChanged is not provided',
        () {
      // given
      var onStateChangedCallCount = 0;
      final sut = RoundedSelectableButtonScreenModel();
      sut.onStateChanged = () => onStateChangedCallCount++;

      // when
      sut.onPressedAction?.call();

      // then
      expect(sut.onPressedAction, isNull);
      expect(onStateChangedCallCount, 0);
    });

    for (final initiallySelected in [true, false]) {
      test(
          'onPressedAction toggles isSelected from $initiallySelected to ${!initiallySelected}',
          () {
        // given
        var onSelectionChangedCallCount = 0;
        var onStateChangedCallCount = 0;
        final sut = RoundedSelectableButtonScreenModel(
          initiallySelected: initiallySelected,
          onSelectionChanged: (_) => onSelectionChangedCallCount++,
        );
        sut.onStateChanged = () => onStateChangedCallCount++;

        // when
        sut.onPressedAction?.call();

        // then
        expect(sut.isSelected, !initiallySelected);
        expect(onSelectionChangedCallCount, 1);
        expect(onStateChangedCallCount, 1);
      });
    }

    // MARK: - backgroundColor

    test('backgroundColor returns white when not selected', () {
      // given
      final sut = RoundedSelectableButtonScreenModel();

      // then
      expect(sut.backgroundColor, Colors.white);
    });

    test('backgroundColor returns lightBlueAccent when selected', () {
      // given
      final sut = RoundedSelectableButtonScreenModel(initiallySelected: true);

      // then
      expect(sut.backgroundColor, Colors.lightBlueAccent);
    });

    // MARK: - borderColor

    test('borderColor returns black when not selected', () {
      // given
      final sut = RoundedSelectableButtonScreenModel();

      // then
      expect(sut.borderColor, Colors.black);
    });

    test('borderColor returns blue when selected', () {
      // given
      final sut = RoundedSelectableButtonScreenModel(initiallySelected: true);

      // then
      expect(sut.borderColor, Colors.blue);
    });
  });
}
