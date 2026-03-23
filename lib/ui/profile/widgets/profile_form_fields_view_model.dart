import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';

class ProfileFormFieldsViewModel extends ChangeNotifier {
  final ImagePicker _picker;
  XFile? _pickedImage;
  String? _existingImagePath;
  final nameTextController = TextEditingController();
  final AbstractTextValidator nameValidator;
  final Map<ActivitiesConfig, bool> _activities = {
    for (final activity in ActivitiesConfig.values) activity: false,
  };
  final AbstractProfilesRepository _profileRepository;
  Function()? onStateChanged;

  ProfileFormFieldsViewModel({
    AbstractTextValidator? nameValidator,
    ProfileDomain? initialProfile,
    AbstractProfilesRepository? profileRepository,
    ImagePicker? imagePicker,
  })  : nameValidator = nameValidator ??
            TextLengthValidator(
              minimumLength: ProfileConfig.nameMinLength,
              maximumLength: ProfileConfig.nameMaxLength,
            ),
        _profileRepository = profileRepository ?? ProfilesRepository(),
        _picker = imagePicker ?? ImagePicker() {
    nameTextController.addListener(_onStateChanged);
    if (initialProfile != null) {
      loadFromProfile(initialProfile);
    }
  }

  void _onStateChanged() {
    onStateChanged?.call();
  }

  Future<void> pickImage() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (picked != null) {
        _pickedImage = picked;
        onStateChanged?.call();
      }
    } catch (e) {
      // TODO handle error
      print('Image pick error: $e');
    }
  }

  String? getPickedProfileImagePath() {
    return _pickedImage?.path ?? _existingImagePath;
  }

  void loadFromProfile(ProfileDomain profile) {
    nameTextController.text = profile.name;
    _existingImagePath = profile.profileImagePath;
    for (final entry in profile.activities.entries) {
      _activities[entry.key] = entry.value;
    }
    onStateChanged?.call();
  }

  Map<String, bool> get displayActivities {
    return {
      for (final entry in _activities.entries)
        entry.key.displayName: entry.value,
    };
  }

  void updateActivitiesByDisplayName(String displayName, bool isSelected) {
    final activity = _activities.keys.firstWhere(
      (activity) => activity.displayName == displayName,
    );
    _activities[activity] = isSelected;
    onStateChanged?.call();
  }

  bool get hasPickedImage => _pickedImage != null;

  bool get hasImage =>
      _pickedImage != null || _existingImagePath != null;

  bool get hasSelectedActivities =>
      _activities.values.any((isSelected) => isSelected);

  VoidCallback? getSaveButtonAction(VoidCallback onSaved) {
    final hasName = nameValidator.validate(nameTextController.text) == null;

    if (!hasImage || !hasName || !hasSelectedActivities) return null;

    return () {
      saveProfile().then((_) {
        onSaved();
      });
    };
  }

  VoidCallback? getSaveAndPopAction(NavigatorState navigator) {
    return getSaveButtonAction(() => navigator.pop());
  }

  Future<void> saveProfile() async {
    final imagePath = _pickedImage?.path ?? _existingImagePath;
    final profile = ProfileDomain(
      name: nameTextController.text,
      profileImagePath: imagePath!,
      activities: Map<ActivitiesConfig, bool>.from(_activities),
    );
    await _profileRepository.addProfile(profile);
  }

  void disposeControllers() {
    nameTextController.removeListener(_onStateChanged);
    nameTextController.dispose();
  }
}
