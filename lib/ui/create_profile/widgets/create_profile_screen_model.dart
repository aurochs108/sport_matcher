import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/core/utilities/validators/minimum_text_length_validator.dart';

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
  Function()? onStateChanged;

  CreateProfileScreenModel({
    AbstractTextValidator? nameValidator,
  }) : nameValidator =
            nameValidator ?? MinimumTextLengthValidator(minimumLength: 2) {
    nameTextController.addListener(_updateSaveButtonState);
  }

  void updateActivites(String activity, bool isSelected) {
    _activities[activity] = isSelected;
    _updateSaveButtonState();
  }

  void _updateSaveButtonState() {
    isNextButtonActive = nameTextController.text.length > 1 && _hasSelectedActivities();
    onStateChanged?.call();
  }

  bool _hasSelectedActivities() {
    return activities.values.firstWhere((isSelected) => isSelected, orElse: () => false);
  }

   VoidCallback? getNextButtonAction(BuildContext buildContext) {
    if (isNextButtonActive) {
      return () {
        Navigator.of(buildContext).push(
          MaterialPageRoute(
            builder: (_) => BottomNavigationBarScreen(),
          ),
        );
      };
    } else {
      return null;
    }
  }

  void disposeControllers() {
    nameTextController.removeListener(_updateSaveButtonState);
    nameTextController.dispose();
  }
}
