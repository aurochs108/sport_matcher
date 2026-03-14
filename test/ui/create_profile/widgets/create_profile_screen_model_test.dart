import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/mock_navigator_observer.dart';
import '../../../utilities/random_string.dart';
import 'create_profile_screen_model_test.mocks.dart';

@GenerateMocks([
  AbstractTextValidator,
  AbstractProfilesRepository,
])
class MockImagePicker extends ImagePicker {
  MockImagePicker();

  XFile? pickedImageReturnValue;

  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    return pickedImageReturnValue;
  }
}

void main() {
  group('CreateProfileScreenModel', () {
    late MockImagePicker imagePicker;
    late MockAbstractTextValidator nameValidator;
    late MockAbstractProfilesRepository profileRepository;
    late CreateProfileScreenModel sut;

    setUp(() {
      nameValidator = MockAbstractTextValidator();
      profileRepository = MockAbstractProfilesRepository();
      imagePicker = MockImagePicker();
      sut = CreateProfileScreenModel(
        nameValidator: nameValidator,
        profileRepository: profileRepository,
        imagePicker: imagePicker,
      );
    });

    // MARK: - updateActivitiesByDisplayName

    test('should update activities by display name', () {
      // given
      final activitiesKeys = sut.displayActivities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
      final expectedIsSelected = Random().nextBool();
      var activitiesCopy = Map<String, bool>.from(sut.displayActivities);

      // when
      sut.updateActivitiesByDisplayName(activity, expectedIsSelected);

      // then
      activitiesCopy[activity] = expectedIsSelected;
      expect(sut.displayActivities, activitiesCopy);
    });

    // MARK: - next button activation

    test(
        'should activate next button when has selected image, name is valid and has selected activities',
        () async {
      // given
      when(nameValidator.validate(any)).thenReturn(null);
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');

      // when
      await sut.pickImage();

      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      final activitiesKeys = sut.displayActivities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
      sut.updateActivitiesByDisplayName(activity, true);

      // then
      expect(sut.isNextButtonActive, isTrue);
    });

    test('should deactivate next button when name is invalid', () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
      await sut.pickImage();

      when(nameValidator.validate(any)).thenReturn('Invalid name');

      final activitiesKeys = sut.displayActivities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
      sut.updateActivitiesByDisplayName(activity, true);

      // when
      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    test(
        'should have active next button and when user unselect activity next button should be deactivated',
        () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
      await sut.pickImage();

      when(nameValidator.validate(any)).thenReturn(null);
      final randomString = RandomString();
      sut.nameTextController.text =
          randomString.nextString(length: Random().nextInt(10));

      final activitiesKeys = sut.displayActivities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
  
      sut.updateActivitiesByDisplayName(activity, true);

      expect(sut.isNextButtonActive, isTrue);

      // when
      sut.updateActivitiesByDisplayName(activity, false);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

      // MARK: - getNextButtonAction

      testWidgets('getNextButtonAction pushes BottomNavigationBarScreen',
          (WidgetTester tester) async {
        // given
        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();

        when(nameValidator.validate(any)).thenReturn(null);
        sut.nameTextController.text = Uuid().v4();

        sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

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
        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();

        when(nameValidator.validate(any)).thenReturn(null);

        sut.nameTextController.text = '';
        sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, false);

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
