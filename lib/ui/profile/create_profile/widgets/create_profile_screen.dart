import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';
import 'package:sport_matcher/ui/core/utilities/validators/text_length_validator.dart';
import 'package:sport_matcher/ui/profile/create_profile/widgets/create_profile_screen_model.dart';
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
  final _formModel = ProfileFormFieldsScreenModel(
    nameValidator: TextLengthValidator(
      minimumLength: ProfileConfig.nameMinLength,
      maximumLength: ProfileConfig.nameMaxLength,
    ),
  );
  final _viewModel = CreateProfileScreenModel();

  @override
  void initState() {
    super.initState();
    _formModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    _formModel.disposeControllers();
    _formModel.dispose();
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
          imagePath: _formModel.getPickedProfileImagePath(),
          onPickImage: _formModel.pickImage,
          nameController: _formModel.nameTextController,
          nameValidator: _formModel.nameValidator,
          activities: _formModel.displayActivities,
          onActivityChanged: (activityName, isSelected) {
            _formModel.updateActivitiesByDisplayName(activityName, isSelected);
          },
          buttonTitle: "Next",
          onButtonPressed: _formModel.getSaveButtonAction(
            _viewModel.navigateToHomeAction(Navigator.of(context)),
          ),
        ),
      ),
    );
  }
}
