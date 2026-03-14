import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/mock_navigator_observer.dart';
import '../../../utilities/build_context_provider.dart';
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

    testWidgets(
        'should activate next button when has selected image, name is valid and has selected activities',
        (WidgetTester tester) async {
      // given
      final buildContext = await BuildContextProvider.get(tester);

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
      expect(sut.getNextButtonAction(buildContext), isNotNull);
    });

    testWidgets('should deactivate next button when name is invalid',
        (WidgetTester tester) async {
      // given
      final buildContext = await BuildContextProvider.get(tester);

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
      expect(sut.getNextButtonAction(buildContext), isNull);
    });

    testWidgets(
        'should have active next button and when user unselect activity next button should be deactivated',
        (WidgetTester tester) async {
      // given
      final buildContext = await BuildContextProvider.get(tester);

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

      expect(sut.getNextButtonAction(buildContext), isNotNull);

      // when
      sut.updateActivitiesByDisplayName(activity, false);

      // then
      expect(sut.getNextButtonAction(buildContext), isNull);
    });

      // MARK: - getNextButtonAction

      testWidgets('getNextButtonAction pushes BottomNavigationBarScreen',
          (WidgetTester tester) async {
        // given
        when(nameValidator.validate(any)).thenReturn(null);

        imagePicker.pickedImageReturnValue = XFile('path/to/image.jpg');
        await sut.pickImage();

        sut.nameTextController.text = Uuid().v4();

        sut.updateActivitiesByDisplayName(sut.displayActivities.keys.first, true);

        when(profileRepository.addProfile(any)).thenAnswer((_) async {});

        final observer = TestNavigatorObserver();
        final buildContext = await BuildContextProvider.getWithObserver(tester, observer);

        // when
        sut.getNextButtonAction(buildContext)?.call();
        await tester.pumpAndSettle();

        // then
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

        when(profileRepository.addProfile(any)).thenAnswer((_) async {});

        final observer = TestNavigatorObserver();
        final buildContext = await BuildContextProvider.getWithObserver(tester, observer);

        // when
        sut.getNextButtonAction(buildContext)?.call();

        // then
        expect(find.byType(BottomNavigationBarScreen), findsNothing);

        verifyNever(profileRepository.addProfile(any));
      });
   });
}
