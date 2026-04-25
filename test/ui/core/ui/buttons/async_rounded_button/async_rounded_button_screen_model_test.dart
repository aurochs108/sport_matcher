import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/ui/buttons/async_rounded_button/async_rounded_button_screen_model.dart';

void main() {
  group('AsyncRoundedButtonScreenModel', () {
    // MARK: - state

    test('is disabled by default', () {
      final sut = AsyncRoundedButtonScreenModel();

      expect(sut.isLoading, isFalse);
      expect(sut.isEnabled, isFalse);
      expect(sut.backgroundColor, Colors.grey);
    });

    test('setting onPressed enables button and notifies state change', () {
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onStateChanged = () => onStateChangedCallCount++;

      sut.onPressed = () async {};

      expect(sut.isEnabled, isTrue);
      expect(sut.backgroundColor, Colors.blue);
      expect(onStateChangedCallCount, 1);
    });

    test('setting same onPressed does not notify state change again', () {
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onStateChanged = () => onStateChangedCallCount++;
      Future<void> callback() async {}

      sut.onPressed = callback;
      sut.onPressed = callback;

      expect(onStateChangedCallCount, 1);
    });

    test('setting onPressed to null disables button and notifies state change', () {
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onStateChanged = () => onStateChangedCallCount++;
      sut.onPressed = () async {};

      sut.onPressed = null;

      expect(sut.isEnabled, isFalse);
      expect(sut.backgroundColor, Colors.grey);
      expect(onStateChangedCallCount, 2);
    });

    // MARK: - handlePressed

    test('handlePressed does nothing when onPressed is null', () async {
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onStateChanged = () => onStateChangedCallCount++;

      await sut.handlePressed();

      expect(sut.isLoading, isFalse);
      expect(sut.isEnabled, isFalse);
      expect(onStateChangedCallCount, 0);
    });

    test('handlePressed toggles loading state while action runs', () async {
      final completer = Completer<void>();
      var onPressedCallCount = 0;
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onPressed = () async {
          onPressedCallCount += 1;
          await completer.future;
        }
        ..onStateChanged = () => onStateChangedCallCount++;

      final future = sut.handlePressed();

      expect(onPressedCallCount, 1);
      expect(sut.isLoading, isTrue);
      expect(sut.isEnabled, isFalse);
      expect(sut.backgroundColor, Colors.grey);
      expect(onStateChangedCallCount, 1);

      completer.complete();
      await future;

      expect(sut.isLoading, isFalse);
      expect(sut.isEnabled, isTrue);
      expect(sut.backgroundColor, Colors.blue);
      expect(onStateChangedCallCount, 2);
    });

    test('handlePressed resets loading state and rethrows when action fails', () async {
      final exception = Exception('failure');
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onPressed = () async {
          throw exception;
        }
        ..onStateChanged = () => onStateChangedCallCount++;

      await expectLater(sut.handlePressed(), throwsA(same(exception)));

      expect(sut.isLoading, isFalse);
      expect(sut.isEnabled, isTrue);
      expect(sut.backgroundColor, Colors.blue);
      expect(onStateChangedCallCount, 2);
    });

    test('handlePressed ignores re-entrant calls', () async {
      final completer = Completer<void>();
      var onPressedCallCount = 0;
      var onStateChangedCallCount = 0;
      final sut = AsyncRoundedButtonScreenModel()
        ..onPressed = () async {
          onPressedCallCount += 1;
          await completer.future;
        }
        ..onStateChanged = () => onStateChangedCallCount++;

      final first = sut.handlePressed();
      final second = sut.handlePressed();

      expect(onPressedCallCount, 1);
      expect(sut.isLoading, isTrue);
      expect(sut.isEnabled, isFalse);
      expect(onStateChangedCallCount, 1);

      completer.complete();
      await first;
      await second;

      expect(onPressedCallCount, 1);
      expect(sut.isLoading, isFalse);
      expect(sut.isEnabled, isTrue);
      expect(sut.backgroundColor, Colors.blue);
      expect(onStateChangedCallCount, 2);
    });
  });
}
