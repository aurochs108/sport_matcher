import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_view.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _viewModel = ProfileFormFieldsScreenModel(
    nameValidator: TextLengthValidator(
      minimumLength: ProfileConfig.nameMinLength,
      maximumLength: ProfileConfig.nameMaxLength,
    ),
  );

  @override
  void initState() {
    super.initState();
    _viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    _viewModel.disposeControllers();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Create profile"),
        ),
        body: ProfileFormFieldsView(
          imagePath: _viewModel.getPickedProfileImagePath(),
          onPickImage: _viewModel.pickImage,
          nameController: _viewModel.nameTextController,
          nameValidator: _viewModel.nameValidator,
          activities: _viewModel.displayActivities,
          onActivityChanged: (activityName, isSelected) {
            _viewModel.updateActivitiesByDisplayName(
              activityName,
              isSelected,
            );
          },
          buttonTitle: "Next",
          onButtonPressed: _getNextButtonAction(),
        ),
      ),
    );
  }

  VoidCallback? _getNextButtonAction() {
    final isActive = _viewModel.hasPickedImage &&
        _viewModel.nameValidator
                ?.validate(_viewModel.nameTextController.text) ==
            null &&
        _viewModel.hasSelectedActivities;

    if (!isActive) return null;

    final navigator = Navigator.of(context);
    return () {
      _viewModel.saveProfile().then((_) {
        navigator.push(
          MaterialPageRoute(
            builder: (_) => BottomNavigationBarScreen(),
          ),
        );
      });
    };
  }
}
