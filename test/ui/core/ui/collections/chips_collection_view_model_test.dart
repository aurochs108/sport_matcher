import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_collection_view_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ChipsCollectionViewModel', () {
    // MARK: - itemKeys

    test('itemKeys returns all keys from items', () {
      // given
      final items = {Uuid().v4(): true, Uuid().v4(): false, Uuid().v4(): true};
      final sut = ChipsCollectionViewModel(items: items);

      // then
      expect(sut.itemKeys, items.keys.toList());
    });

    // MARK: - isSelected

    for (final isSelected in [true, false]) {
      test(
        'isSelected returns $isSelected for item with value $isSelected',
        () {
          // given
          final element = Uuid().v4();
          final sut = ChipsCollectionViewModel(items: {element: isSelected});

          // then
          expect(sut.isSelected(element), isSelected);
        },
      );
    }

    test('isSelected returns false for unknown item', () {
      // given
      final sut = ChipsCollectionViewModel(items: {});

      // then
      expect(sut.isSelected(Uuid().v4()), false);
    });

    // MARK: - getOnSelectionChanged

    test(
      'getOnSelectionChanged returns null when onSelectionChanged is not provided',
      () {
        // given
        final element = Uuid().v4();
        final sut = ChipsCollectionViewModel(items: {element: false});

        // then
        expect(sut.getOnSelectionChanged(element), isNull);
      },
    );

    for (final newValue in [true, false]) {
      test(
        'getOnSelectionChanged updates item to $newValue and calls callbacks',
        () {
          // given
          String? receivedItem;
          bool? receivedValue;
          var onStateChangedCallCount = 0;
          final element = Uuid().v4();

          final sut = ChipsCollectionViewModel(
            items: {element: !newValue},
            onSelectionChanged: (item, value) {
              receivedItem = item;
              receivedValue = value;
            },
          );
          sut.onStateChanged = () => onStateChangedCallCount++;

          // when
          sut.getOnSelectionChanged(element)?.call(newValue);

          // then
          expect(sut.isSelected(element), newValue);
          expect(receivedItem, element);
          expect(receivedValue, newValue);
          expect(onStateChangedCallCount, 1);
        },
      );
    }
  });
}
