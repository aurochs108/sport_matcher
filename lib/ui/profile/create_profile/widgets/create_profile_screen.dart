import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/profile/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields.dart';

class CreateProfileScreen extends StatefulWidget {
  final CreateProfileScreenModel _viewModel;

  CreateProfileScreen({super.key}) : _viewModel = CreateProfileScreenModel();

  @override
  State<StatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  void initState() {
    super.initState();
    widget._viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    widget._viewModel.disposeControllers();
    widget._viewModel.dispose();
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
        body: Padding(
          padding: AppTheme.horizontalAndBottomPadding(context),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: AppTheme.columnVerticalPaddings(context),
                    child: ProfileFormFields(
                      imagePath: widget._viewModel.getPickedProfileImagePath(),
                      onPickImage: widget._viewModel.pickImage,
                      nameController: widget._viewModel.nameTextController,
                      nameValidator: widget._viewModel.nameValidator,
                      activities: widget._viewModel.displayActivities,
                      onActivityChanged: (activityName, isSelected) {
                        widget._viewModel.updateActivitiesByDisplayName(
                          activityName,
                          isSelected,
                        );
                      },
                    ),
                  ),
                ),
              ),
              RoundedButton(
                buttonTitle: "Next",
                onPressed: widget._viewModel.getNextButtonAction(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
