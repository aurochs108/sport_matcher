import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../utilities/random_string.dart';
import '../../../mocks/mock_navigator_observer.dart';
import 'create_profile_screen_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator])
void main() {
  group('CreateProfileScreenModel', () {
    late MockAbstractTextValidator nameValidator;
    late CreateProfileScreenModel sut;

    setUp(() {
      nameValidator = MockAbstractTextValidator();
      sut = CreateProfileScreenModel(
        nameValidator: nameValidator,
      );
    });

    // MARK: - updateActivites

    test('should activate button when both validators return null', () {
      // given
      final activitiesKeys = sut.activities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
      final expectedIsSelected = Random().nextBool();
      var activitiesCopy = Map<String, bool>.from(sut.activities);

      // when
      sut.updateActivites(activity, expectedIsSelected);

      // then
      activitiesCopy[activity] = expectedIsSelected;
      expect(sut.activities, activitiesCopy);
    });

    // MARK: - next button activation

    test(
        'should activate next button when name got proper length and has selected activities',
        () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);

      // when
      final randomString = RandomString();
      sut.nameTextController.text = randomString.nextString(length: 2);

      final activitiesKeys = sut.activities.keys.toList();
      final activity = activitiesKeys.first;
      sut.updateActivites(activity, true);

      // then
      expect(sut.isNextButtonActive, isTrue);
    });

    test('should deactivate next button when got not proper length', () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);
      final activitiesKeys = sut.activities.keys.toList();
      final activity = activitiesKeys.first;
      sut.updateActivites(activity, true);

      // when
      final randomString = RandomString();
      sut.nameTextController.text = randomString.nextString(length: 1);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    test('should deactivate next button when no activities have been selected',
        () {
      // given
      final randomString = RandomString();
      sut.nameTextController.text = randomString.nextString(length: 2);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    // MARK: - getNextButtonAction

    testWidgets('getNextButtonAction pushes BottomNavigationBarScreen',
        (WidgetTester tester) async {
      // given
      final model = CreateProfileScreenModel();
      model.nameTextController.text = 'ab';
      model.updateActivites(model.activities.keys.first, true);

      final observer = TestNavigatorObserver();
      final buttonName = const Uuid().v4();

      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          return ElevatedButton(
            key: Key(buttonName),
            onPressed: model.getNextButtonAction(context),
            child: const Text(''),
          );
        }),
        navigatorObservers: [observer],
      ));

      // when
      final initialPushCount = observer.pushCount;
      await tester.tap(find.byKey(Key(buttonName)));
      await tester.pumpAndSettle();

      // then
      expect(observer.pushCount, initialPushCount + 1);
      expect(observer.lastPushedRoute, isA<MaterialPageRoute>());
      expect(find.byType(BottomNavigationBarScreen), findsOneWidget);
    });

    testWidgets('getNextButtonAction does nothing when button is inactive',
        (WidgetTester tester) async {
      // given
      final model = CreateProfileScreenModel();
      model.nameTextController.text = '';
      model.updateActivites(model.activities.keys.first, false);

      final observer = TestNavigatorObserver();
      final buttonName = const Uuid().v4();

      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          return ElevatedButton(
            key: Key(buttonName),
            onPressed: model.getNextButtonAction(context),
            child: const Text(''),
          );
        }),
        navigatorObservers: [observer],
      ));

      // when
      final initialPushCount = observer.pushCount;
      await tester.tap(find.byKey(Key(buttonName)));
      await tester.pumpAndSettle();

      // then
      expect(observer.pushCount, initialPushCount);
      expect(find.byType(BottomNavigationBarScreen), findsNothing);
    });
  });
}
