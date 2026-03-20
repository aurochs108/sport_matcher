import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';

class CreateProfileScreenModel extends ChangeNotifier {
  final ImagePicker _picker;
  XFile? _pickedImage;
  final nameTextController = TextEditingController();
  final AbstractTextValidator nameValidator;
  final Map<ActivitiesConfig, bool> _activities = {
    for (final activity in ActivitiesConfig.values) activity: false,
  };
  var _isNextButtonActive = false;
  final AbstractProfilesRepository _profileRepository;
  Function()? onStateChanged;

  CreateProfileScreenModel({
    AbstractTextValidator? nameValidator,
    AbstractProfilesRepository? profileRepository,
    ImagePicker? imagePicker,
  })  : nameValidator = nameValidator ??
            TextLengthValidator(
                minimumLength: ProfileConfig.nameMinLength,
                maximumLength: ProfileConfig.nameMaxLength),
        _profileRepository = profileRepository ?? ProfilesRepository(),
        _picker = imagePicker ?? ImagePicker() {
    nameTextController.addListener(_updateSaveButtonState);
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
        _updateSaveButtonState();
      }
    } catch (e) {
      // TODO handle error
      print('Image pick error: $e');
    }
  }

  String? _existingImagePath;

  String? getPickedProfileImagePath() {
    return _pickedImage?.path ?? _existingImagePath;
  }

  void loadFromProfile(ProfileDomain profile) {
    nameTextController.text = profile.name;
    _existingImagePath = profile.profileImagePath;
    for (final entry in profile.activities.entries) {
      _activities[entry.key] = entry.value;
    }
    _updateSaveButtonState();
  }

  Map<String, bool> get displayActivities =>
      _mapActivitiesToDisplayNames(_activities);

  Map<String, bool> _mapActivitiesToDisplayNames(
      Map<ActivitiesConfig, bool> activities) {
    return {
      for (final entry in activities.entries)
        entry.key.displayName: entry.value,
    };
  }

  void updateActivitiesByDisplayName(String displayName, bool isSelected) {
    final activity = _activities.keys.firstWhere(
      (activity) => activity.displayName == displayName,
    );
    _activities[activity] = isSelected;
    _updateSaveButtonState();
  }

  void _updateSaveButtonState() {
    _isNextButtonActive = _pickedImage != null &&
        nameValidator.validate(nameTextController.text) == null &&
        _hasSelectedActivities();
    onStateChanged?.call();
  }

  bool _hasSelectedActivities() {
    return _activities.values.any((isSelected) => isSelected);
  }

  VoidCallback? getNextButtonAction(BuildContext buildContext) {
    if (_isNextButtonActive) {
      final navigator = Navigator.of(buildContext);
      return () {
        _saveProfileDate().then((_) {
          navigator.push(
            MaterialPageRoute(
              builder: (_) => BottomNavigationBarScreen(),
            ),
          );
        });
      };
    } else {
      return null;
    }
  }

  Future<void> _saveProfileDate() async {
    final profile = ProfileDomain(
      name: nameTextController.text,
      profileImagePath: _pickedImage!.path, // TODO: HANDLE ERROR!
      activities: Map<ActivitiesConfig, bool>.from(_activities),
    );
    await _profileRepository.addProfile(profile);
  }

  void disposeControllers() {
    nameTextController.removeListener(_updateSaveButtonState);
    nameTextController.dispose();
  }
}
