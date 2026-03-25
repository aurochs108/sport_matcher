import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/profile/create_profile/widgets/create_profile_screen_model.dart';

import '../../../../mocks/mock_navigator_observer.dart';
import '../../../../utilities/build_context_provider.dart';

void main() {
  group('CreateProfileScreenModel', () {
    late CreateProfileScreenModel sut;

    setUp(() {
      sut = CreateProfileScreenModel();
    });

    // MARK: - navigateToHomeAction

    testWidgets('navigateToHomeAction pushes BottomNavigationBarScreen',
        (WidgetTester tester) async {
      // given
      final observer = TestNavigatorObserver();
      final buildContext =
          await BuildContextProvider.getWithObserver(tester, observer);
      final navigator = Navigator.of(buildContext);

      // when
      sut.navigateToHomeAction(navigator);
      await tester.pumpAndSettle();

      // then
      expect(observer.lastPushedRoute, isA<MaterialPageRoute>());
      expect(find.byType(BottomNavigationBarScreen), findsOneWidget);
    });
  });
}
