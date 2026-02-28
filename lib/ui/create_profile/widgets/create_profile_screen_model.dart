import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';

class CreateProfileScreenModel extends ChangeNotifier {
  final nameTextController = TextEditingController();
  final AbstractTextValidator nameValidator;
  final Map<String, bool> _activities = {
    "Bike": false,
    "Climbing": false,
    "Football": false,
    "Hockey": false,
    "Ping Pong": false,
    "Running": false,
    "Tennis": false,
    "Voleyball": false,
  };
  Map<String, bool> get activities => Map.unmodifiable(_activities);
  var isNextButtonActive = false;
  final _profileRepository = ProfilesRepository();
  Function()? onStateChanged;

  CreateProfileScreenModel({
    AbstractTextValidator? nameValidator,
  }) : nameValidator =
            nameValidator ?? TextLengthValidator(minimumLength: ProfileConfig.nameMinLength, maximumLength: ProfileConfig.nameMaxLength) {
    nameTextController.addListener(_updateSaveButtonState);
  }

  void updateActivites(String activity, bool isSelected) {
    _activities[activity] = isSelected;
    _updateSaveButtonState();
  }

  void _updateSaveButtonState() {
    isNextButtonActive =
      nameValidator.validate(nameTextController.text) == null &&
        _hasSelectedActivities();
    onStateChanged?.call();
  }

  bool _hasSelectedActivities() {
    return activities.values
        .firstWhere((isSelected) => isSelected, orElse: () => false);
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
    final profile = ProfileDomain(nameTextController.text);
    await _profileRepository.addProfile(profile);
  }

  void disposeControllers() {
    nameTextController.removeListener(_updateSaveButtonState);
    nameTextController.dispose();
  }
}
