import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/ui/authentication/sign_in/widgets/sign_in_screen.dart';
import 'package:sport_matcher/ui/authentication/sign_up/widgets/sign_up_screen.dart';
import 'package:sport_matcher/ui/authentication/welcome/widgets/welcome_screen_model.dart';

import '../../../../mocks/mock_navigator_observer.dart';
import '../../../../utilities/build_context_provider.dart';

void main() {
  group('WelcomeScreenModel', () {
    late WelcomeScreenModel sut;

    setUp(() {
      sut = WelcomeScreenModel();
    });

    // MARK: - navigateToSignIn

    testWidgets('navigateToSignIn pushes SignInScreen',
        (WidgetTester tester) async {
      // given
      final observer = TestNavigatorObserver();
      final buildContext =
          await BuildContextProvider.getWithObserver(tester, observer);

      // when
      sut.navigateToSignIn(buildContext);
      await tester.pumpAndSettle();

      // then
      expect(observer.lastPushedRoute, isA<MaterialPageRoute>());
      expect(find.byType(SignInScreen), findsOneWidget);
    });

    // MARK: - navigateToSignUp

    testWidgets('navigateToSignUp pushes SignUpScreen',
        (WidgetTester tester) async {
      // given
      final observer = TestNavigatorObserver();
      final buildContext =
          await BuildContextProvider.getWithObserver(tester, observer);

      // when
      sut.navigateToSignUp(buildContext);
      await tester.pumpAndSettle();

      // then
      expect(observer.lastPushedRoute, isA<MaterialPageRoute>());
      expect(find.byType(SignUpScreen), findsOneWidget);
    });
  });
}
