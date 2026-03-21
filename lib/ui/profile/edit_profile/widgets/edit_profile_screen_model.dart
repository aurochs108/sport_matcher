import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';

class EditProfileScreenModel extends ChangeNotifier {
  final ImagePicker _picker;
  XFile? _pickedImage;
  String? _existingImagePath;
  final nameTextController = TextEditingController();
  final Map<ActivitiesConfig, bool> _activities = {
    for (final activity in ActivitiesConfig.values) activity: false,
  };
  final AbstractProfilesRepository _profileRepository;
  Function()? onStateChanged;

  EditProfileScreenModel({
    AbstractProfilesRepository? profileRepository,
    ImagePicker? imagePicker,
  })  : _profileRepository = profileRepository ?? ProfilesRepository(),
        _picker = imagePicker ?? ImagePicker();

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

  VoidCallback getSaveButtonAction(BuildContext buildContext) {
    final navigator = Navigator.of(buildContext);
    return () {
      _updateProfile().then((_) {
        navigator.pop();
      });
    };
  }

  Future<void> _updateProfile() async {
    final updatedProfile = ProfileDomain(
      name: nameTextController.text,
      profileImagePath: _pickedImage?.path ?? _existingImagePath!,
      activities: Map<ActivitiesConfig, bool>.from(_activities),
    );
    await _profileRepository.addProfile(updatedProfile);
  }

  void disposeControllers() {
    nameTextController.dispose();
  }
}
