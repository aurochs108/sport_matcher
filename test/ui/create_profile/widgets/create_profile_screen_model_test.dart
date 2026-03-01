import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../utilities/random_string.dart';
import '../../../mocks/mock_navigator_observer.dart';
import 'create_profile_screen_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator, AbstractProfilesRepository])
void main() {
  group('CreateProfileScreenModel', () {
    late MockAbstractTextValidator nameValidator;
    late MockAbstractProfilesRepository profileRepository;
    late CreateProfileScreenModel sut;

    setUp(() {
      nameValidator = MockAbstractTextValidator();
      profileRepository = MockAbstractProfilesRepository();
      sut = CreateProfileScreenModel(
        nameValidator: nameValidator,
        profileRepository: profileRepository,
      );
    });

    // MARK: - updateActivites

    test('should update activities', () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);

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
        'should activate next button when name is valid and has selected activities',
        () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);

      // when
      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      final activitiesKeys = sut.activities.keys.toList();
      final activity = activitiesKeys.first;
      sut.updateActivites(activity, true);

      // then
      expect(sut.isNextButtonActive, isTrue);
    });

    test('should deactivate next button when name is invalid', () {
      // given
      when(nameValidator.validate(any)).thenReturn('Invalid name');
      final activitiesKeys = sut.activities.keys.toList();
      final activity = activitiesKeys.first;
      sut.updateActivites(activity, true);

      // when
      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    test(
        'should have active next button and when user unselect acitivity next button should be deactivated',
        () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);
      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      final activitiesKeys = sut.activities.keys.toList();
      final activity = activitiesKeys.first;
      sut.updateActivites(activity, true);

      expect(sut.isNextButtonActive, isTrue);

      // when
      sut.updateActivites(activity, false);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    // MARK: - getNextButtonAction

    testWidgets('getNextButtonAction pushes BottomNavigationBarScreen',
        (WidgetTester tester) async {
      // given
      when(nameValidator.validate(any)).thenReturn(null);
      sut.nameTextController.text = Uuid().v4();

      sut.updateActivites(sut.activities.keys.first, true);

      final observer = TestNavigatorObserver();
      final buttonName = const Uuid().v4();

      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          return ElevatedButton(
            key: Key(buttonName),
            onPressed: sut.getNextButtonAction(context),
            child: const Text(''),
          );
        }),
        navigatorObservers: [observer],
      ));

      when(profileRepository.addProfile(any)).thenAnswer((_) async {});

      // when
      final initialPushCount = observer.pushCount;
      await tester.tap(find.byKey(Key(buttonName)));
      await tester.pumpAndSettle();

      // then
      expect(observer.pushCount, initialPushCount + 1);
      expect(observer.lastPushedRoute, isA<MaterialPageRoute>());
      expect(find.byType(BottomNavigationBarScreen), findsOneWidget);

      verify(profileRepository.addProfile(argThat(
        predicate<ProfileDomain?>((profile) {
          return profile != null && profile.name == sut.nameTextController.text;
        }),
      ))).called(1);
    });

    testWidgets('getNextButtonAction does nothing when button is inactive',
        (WidgetTester tester) async {
      // given

      when(nameValidator.validate(any)).thenReturn(null);

      sut.nameTextController.text = '';
      sut.updateActivites(sut.activities.keys.first, false);

      final observer = TestNavigatorObserver();
      final buttonName = const Uuid().v4();

      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (context) {
          return ElevatedButton(
            key: Key(buttonName),
            onPressed: sut.getNextButtonAction(context),
            child: const Text(''),
          );
        }),
        navigatorObservers: [observer],
      ));

      when(profileRepository.addProfile(any)).thenAnswer((_) async {});

      // when
      final initialPushCount = observer.pushCount;
      await tester.tap(find.byKey(Key(buttonName)));
      await tester.pumpAndSettle();

      // then
      expect(observer.pushCount, initialPushCount);
      expect(find.byType(BottomNavigationBarScreen), findsNothing);

      verifyNever(profileRepository.addProfile(any));
    });
  });
}
