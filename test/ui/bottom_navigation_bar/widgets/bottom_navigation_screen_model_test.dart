import 'dart:math';

import 'package:sport_matcher/ui/bottom_navigation_bar/logic/tab_item.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen_model.dart';
import 'package:test/test.dart';

void main() {
  group('EmailAuthenticationScreenModel', () {
    late int onStateChangedCallsCount;
    late BottomNavigationBarScreenModel sut;

    setUp(() {
      sut = BottomNavigationBarScreenModel();
      onStateChangedCallsCount = 0;
      sut.onStateChanged = () {
        onStateChangedCallsCount += 1;
      };
    });

    // MARK: - onItemTapped

    test('onItemTapped', () {
      // given
      final expectedIndex = Random().nextInt(TabItem.values.length);

      // when
      sut.onItemTapped(expectedIndex);

      // then
      expect(sut.currentIndex, TabItem.values[expectedIndex]);
      expect(onStateChangedCallsCount, 1);
    });
  });
}