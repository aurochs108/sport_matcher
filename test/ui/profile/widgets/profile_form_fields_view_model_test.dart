import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_view_model.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/mock_image_picker.dart';
import '../../../utilities/build_context_provider.dart';
import 'profile_form_fields_view_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator, AbstractProfilesRepository])
void main() {
  group('ProfileFormFieldsViewModel', () {
    late MockImagePicker imagePicker;
    late MockAbstractTextValidator nameValidator;
    late MockAbstractProfilesRepository profileRepository;
    late int onStateChangedCallCount;
    final buttonTitle = Uuid().v4();
    late ProfileFormFieldsViewModel sut;

    setUp(() {
      onStateChangedCallCount = 0;
      nameValidator = MockAbstractTextValidator();
      when(nameValidator.validate(any)).thenReturn(null);
      profileRepository = MockAbstractProfilesRepository();
      imagePicker = MockImagePicker();
      sut = ProfileFormFieldsViewModel(
        buttonTitle: buttonTitle,
        nameValidator: nameValidator,
        profileRepository: profileRepository,
        imagePicker: imagePicker,
      );
      sut.onStateChanged = () {
        onStateChangedCallCount++;
      };
    });

    // MARK: - buttonTitle

    test('buttonTitle returns provided value', () {
      // then
      expect(sut.buttonTitle, buttonTitle);
    });

    // MARK: - getButtonAction

    test('getButtonAction returns null when not provided', () {
      // then
      expect(sut.getButtonAction, isNull);
    });

    test('getButtonAction returns provided callback', () {
      // given
      final sut = ProfileFormFieldsViewModel(
        buttonTitle: buttonTitle,
        getButtonAction: (model) => () {},
        nameValidator: nameValidator,
        profileRepository: profileRepository,
        imagePicker: imagePicker,
      );

      // then
      expect(sut.getButtonAction, isNotNull);
      expect(sut.getButtonAction?.call(sut), isNotNull);
    });

    // MARK: - dispose

    test('dispose disposes nameTextController', () {
      // when
      sut.dispose();

      // then
      expect(() => sut.nameTextController.text = Uuid().v4(), throwsFlutterError);
    });

    // MARK: - pickImage

    test('should update picked image path on successful image pick', () async {
      // given
      final expectedImagePath = 'path/to/image.jpg';
      imagePicker.pickedImageReturnValue = XFile(expectedImagePath);

      final actualOnStateChangedCallCount = onStateChangedCallCount;

      // when
      await sut.pickImage();

      // then
      expect(sut.profileImagePath, expectedImagePath);
      expect(actualOnStateChangedCallCount + 1, onStateChangedCallCount);
    });

    test(
      'should not update picked image path when image is not picked',
      () async {
        // given
        imagePicker.pickedImageReturnValue = null;

        final actualOnStateChangedCallCount = onStateChangedCallCount;

        // when
        await sut.pickImage();

        // then
        expect(sut.profileImagePath, isNull);
        expect(actualOnStateChangedCallCount, onStateChangedCallCount);
      },
    );

    // MARK: - displayActivities

    test('should map activities to display names', () {
      // given
      final expectedDisplayActivities = {
        for (final activity in ActivitiesConfig.values)
          activity.displayName: false,
      };

      // when
      final displayActivities = sut.displayActivities;

      // then
      expect(displayActivities, expectedDisplayActivities);
    });

    // MARK: - updateActivitiesByDisplayName

    test('should update activities by display name', () {
      // given
      final activitiesKeys = sut.displayActivities.keys.toList();
      activitiesKeys.shuffle();
      final activity = activitiesKeys.first;
      final expectedIsSelected = Random().nextBool();
      var activitiesCopy = Map<String, bool>.from(sut.displayActivities);

      final actualOnStateChangedCallCount = onStateChangedCallCount;

      // when
      sut.updateActivitiesByDisplayName(activity, expectedIsSelected);

      // then
      activitiesCopy[activity] = expectedIsSelected;
      expect(sut.displayActivities, activitiesCopy);
      expect(actualOnStateChangedCallCount + 1, onStateChangedCallCount);
    });

    // MARK: - hasImage

    test('hasImage returns true after picking image', () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');

      // when
      await sut.pickImage();

      // then
      expect(sut.hasImage, true);
    });

    test('hasImage returns false when no image picked', () {
      // then
      expect(sut.hasImage, false);
    });

    // MARK: - hasPickedImage

    test('hasPickedImage returns true after picking image', () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');

      // when
      await sut.pickImage();

      // then
      expect(sut.hasPickedImage, true);
    });

    test('hasPickedImage returns false when no image picked', () {
      // then
      expect(sut.hasPickedImage, false);
    });

    test('hasPickedImage returns false when only existing image path', () {
      // given
      final profile = ProfileDomain(
        name: Uuid().v4(),
        profileImagePath: 'path/to/image.jpg',
        activities: {
          for (final activity in ActivitiesConfig.values) activity: false,
        },
      );
      sut.loadFromProfile(profile);

      // then
      expect(sut.hasPickedImage, false);
      expect(sut.hasImage, true);
    });

    // MARK: - hasSelectedActivities

    test('hasSelectedActivities returns true when activity is selected', () {
      // when
      sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

      // then
      expect(sut.hasSelectedActivities, true);
    });

    test(
      'hasSelectedActivities returns false when no activity is selected',
      () {
        // then
        expect(sut.hasSelectedActivities, false);
      },
    );

    // MARK: - getSaveButtonAction

    test(
      'getSaveButtonAction returns callback when has image, name and activities',
      () async {
        // given
        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();

        sut.nameTextController.text = Uuid().v4();

        sut.updateActivitiesByDisplayName(
          sut.displayActivities.keys.first,
          true,
        );

        // then
        expect(sut.getSaveButtonAction(() {}), isNotNull);
      },
    );

    test('getSaveButtonAction returns null when no image', () {
      // given
      sut.nameTextController.text = Uuid().v4();
      sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

      // then
      expect(sut.getSaveButtonAction(() {}), isNull);
    });

    test('getSaveButtonAction returns null when name is invalid', () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
      await sut.pickImage();

      when(nameValidator.validate(any)).thenReturn('Name too short');
      sut.nameTextController.text = 'A';
      sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

      // then
      expect(sut.getSaveButtonAction(() {}), isNull);
    });

    test(
      'getSaveButtonAction returns null when no activities selected',
      () async {
        // given
        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();

        sut.nameTextController.text = Uuid().v4();

        // then
        expect(sut.getSaveButtonAction(() {}), isNull);
      },
    );

    test('getSaveButtonAction saves profile and calls onSaved', () async {
      // given
      final profileImagePath = 'path/to/image.jpg';
      imagePicker.pickedImageReturnValue = XFile(profileImagePath);
      await sut.pickImage();

      sut.nameTextController.text = Uuid().v4();

      final activityToSelect = ActivitiesConfig.values.first;
      final expectedActivities = {
        for (final activity in ActivitiesConfig.values) activity: false,
      };
      expectedActivities[activityToSelect] = true;
      sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

      when(profileRepository.addProfile(any)).thenAnswer((_) async {});

      var onSavedCalled = false;

      // when
      sut.getSaveButtonAction(() => onSavedCalled = true)?.call();
      await Future.delayed(Duration.zero);

      // then
      expect(onSavedCalled, true);

      verify(
        profileRepository.addProfile(
          argThat(
            predicate<ProfileDomain?>((profile) {
              return profile != null &&
                  profile.name == sut.nameTextController.text &&
                  profile.profileImagePath == profileImagePath &&
                  mapEquals(profile.activities, expectedActivities);
            }),
          ),
        ),
      ).called(1);
    });

    // MARK: - getSaveAndPopAction

    testWidgets(
      'getSaveAndPopAction returns null when conditions not met',
      (WidgetTester tester) async {
        // given
        final buildContext = await BuildContextProvider.get(tester);
        final navigator = Navigator.of(buildContext);

        // then
        expect(sut.getSaveAndPopAction(navigator), isNull);
      },
    );

    testWidgets(
      'getSaveAndPopAction returns callback when conditions met',
      (WidgetTester tester) async {
        // given
        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();
        sut.nameTextController.text = Uuid().v4();
        sut.updateActivitiesByDisplayName(
            sut.displayActivities.keys.first, true);

        final buildContext = await BuildContextProvider.get(tester);
        final navigator = Navigator.of(buildContext);

        // then
        expect(sut.getSaveAndPopAction(navigator), isNotNull);
      },
    );

    // MARK: - loadFromProfile

    test('loadFromProfile populates fields from profile', () {
      // given
      final profile = ProfileDomain(
        name: Uuid().v4(),
        profileImagePath: 'path/to/image.jpg',
        activities: {
          for (final activity in ActivitiesConfig.values) activity: false,
          ActivitiesConfig.values.first: true,
        },
      );

      final actualOnStateChangedCallCount = onStateChangedCallCount;

      // when
      sut.loadFromProfile(profile);

      // then
      expect(sut.nameTextController.text, profile.name);
      expect(sut.profileImagePath, profile.profileImagePath);
      expect(sut.hasImage, true);
      expect(
        onStateChangedCallCount,
        greaterThan(actualOnStateChangedCallCount),
      );
    });
  });
}
