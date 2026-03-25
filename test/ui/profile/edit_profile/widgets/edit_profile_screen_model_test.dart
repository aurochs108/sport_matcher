import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/profile/edit_profile/widgets/edit_profile_screen_model.dart';

import '../../../../mocks/mock_navigator_observer.dart';
import '../../../../utilities/build_context_provider.dart';

void main() {
  group('EditProfileScreenModel', () {
    late EditProfileScreenModel sut;

    setUp(() {
      sut = EditProfileScreenModel();
    });

    // MARK: - onSavedAction

    testWidgets('onSavedAction pops navigator', (WidgetTester tester) async {
      // given
      final observer = TestNavigatorObserver();
      final buildContext = await BuildContextProvider.getWithObserver(
        tester,
        observer,
      );
      final navigator = Navigator.of(buildContext);
      final popCountBefore = observer.popCount;

      // when
      sut.onSavedAction(navigator);
      await tester.pumpAndSettle();

      // then
      expect(observer.popCount, popCountBefore + 1);
    });
  });
}
