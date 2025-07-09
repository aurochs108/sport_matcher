import 'dart:math';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../../../utilities/string_random.dart';
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
  
    test('should activate next button when name got proper length and has selected activities', () {
      // given
      when(nameValidator.validate(any)).thenReturn(null);

      // when
      sut.nameTextController.text = RandomString.nextString(length: 2);
    
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
      sut.nameTextController.text = RandomString.nextString(length: 1);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });

    test('should deactivate next button when no activities have been selected', () {
      // given
      sut.nameTextController.text = RandomString.nextString(length: 2);

      // then
      expect(sut.isNextButtonActive, isFalse);
    });
  });
}