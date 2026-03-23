import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_screen_model.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/mock_image_picker.dart';
import 'profile_form_fields_screen_model_test.mocks.dart';

@GenerateMocks([AbstractTextValidator, AbstractProfilesRepository])
void main() {
  group('ProfileFormFieldsScreenModel', () {
    late MockImagePicker imagePicker;
    late MockAbstractTextValidator nameValidator;
    late MockAbstractProfilesRepository profileRepository;
    var onStateChangedCallCount = 0;
    late ProfileFormFieldsScreenModel sut;

    setUp(() {
      nameValidator = MockAbstractTextValidator();
      profileRepository = MockAbstractProfilesRepository();
      imagePicker = MockImagePicker();
      sut = ProfileFormFieldsScreenModel(
        nameValidator: nameValidator,
        profileRepository: profileRepository,
        imagePicker: imagePicker,
      );
      sut.onStateChanged = () {
        onStateChangedCallCount++;
      };
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
      expect(sut.getPickedProfileImagePath(), expectedImagePath);
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
        expect(sut.getPickedProfileImagePath(), isNull);
        expect(actualOnStateChangedCallCount, onStateChangedCallCount);
      },
    );

    // MARK: - displayActivities

    test('should map activities to display names', () {
      // given
      final expectedDisplayActivities = {
        'Bike': false,
        'Climbing': false,
        'Football': false,
        'Hockey': false,
        'Ping Pong': false,
        'Running': false,
        'Tennis': false,
        'Voleyball': false,
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

    test('getSaveButtonAction returns null when no name', () async {
      // given
      imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
      await sut.pickImage();

      sut.nameTextController.text = '';
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
      expect(sut.getPickedProfileImagePath(), profile.profileImagePath);
      expect(sut.hasImage, true);
      expect(
        onStateChangedCallCount,
        greaterThan(actualOnStateChangedCallCount),
      );
    });
  });
}
