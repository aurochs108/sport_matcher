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
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  final nameTextController = TextEditingController();
  final AbstractTextValidator nameValidator;
  final Map<ActivitiesConfig, bool> _activities = {
    for (final activity in ActivitiesConfig.values) activity: false,
  };
  Map<ActivitiesConfig, bool> get activities => Map.unmodifiable(_activities);
  var isNextButtonActive = false;
  final AbstractProfilesRepository _profileRepository;
  Function()? onStateChanged;

  CreateProfileScreenModel({
    AbstractTextValidator? nameValidator,
    AbstractProfilesRepository? profileRepository,
  })  : nameValidator = nameValidator ??
            TextLengthValidator(
                minimumLength: ProfileConfig.nameMinLength,
                maximumLength: ProfileConfig.nameMaxLength),
        _profileRepository = profileRepository ?? ProfilesRepository() {
    nameTextController.addListener(_updateSaveButtonState);
  }

  Map<String, bool> get displayActivities =>
      _mapActivitiesToDisplayNames(_activities);

  Map<String, bool> _mapActivitiesToDisplayNames(
      Map<ActivitiesConfig, bool> activities) {
    return {
      for (final entry in activities.entries)
        _mapActivityToDisplayName(entry.key): entry.value,
    };
  }

  void updateActivitiesByDisplayName(String displayName, bool isSelected) {
    final activity = _activities.keys.firstWhere(
      (activity) => _mapActivityToDisplayName(activity) == displayName,
    );
    _activities[activity] = isSelected;
    _updateSaveButtonState();
  }

  String _mapActivityToDisplayName(ActivitiesConfig activity) {
    switch (activity) {
      case ActivitiesConfig.bike:
        return 'Bike';
      case ActivitiesConfig.climbing:
        return 'Climbing';
      case ActivitiesConfig.football:
        return 'Football';
      case ActivitiesConfig.hockey:
        return 'Hockey';
      case ActivitiesConfig.pingPong:
        return 'Ping Pong';
      case ActivitiesConfig.running:
        return 'Running';
      case ActivitiesConfig.tennis:
        return 'Tennis';
      case ActivitiesConfig.voleyball:
        return 'Voleyball';
    }
  }

  void _updateSaveButtonState() {
    isNextButtonActive = pickedImage != null &&
        nameValidator.validate(nameTextController.text) == null &&
        _hasSelectedActivities();
    onStateChanged?.call();
  }

  bool _hasSelectedActivities() {
    return activities.values
        .firstWhere((isSelected) => isSelected, orElse: () => false);
  }

  void pickImage() async {
    pickedImage = null;
    onStateChanged?.call();
    _updateSaveButtonState();

    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (picked != null) {
        pickedImage = picked;
        onStateChanged?.call();
        _updateSaveButtonState();
      }
    } catch (e) {
      // TODO handle error
      print('Image pick error: $e');
    }
  }

  String? getPickedProfileImagePath() {
    return pickedImage?.path;
  }

  VoidCallback? getNextButtonAction(BuildContext buildContext) {
    if (isNextButtonActive) {
      return () {
        _saveProfileDate().then((_) {
          Navigator.of(buildContext).push(
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
      profileImagePath: pickedImage!.path, // TODO: HANDLE ERROR!
      activities: Map<ActivitiesConfig, bool>.from(_activities),
    );
    await _profileRepository.addProfile(profile);
  }

  void disposeControllers() {
    nameTextController.removeListener(_updateSaveButtonState);
    nameTextController.dispose();
  }
}
