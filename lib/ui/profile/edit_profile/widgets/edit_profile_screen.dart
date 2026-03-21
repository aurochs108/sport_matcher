import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/profile/edit_profile/widgets/edit_profile_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileDomain profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _viewModel = EditProfileScreenModel();

  @override
  void initState() {
    super.initState();
    _viewModel.onStateChanged = () {
      setState(() {});
    };
    _viewModel.loadFromProfile(widget.profile);
  }

  @override
  void dispose() {
    _viewModel.disposeControllers();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: AppTheme.horizontalAndBottomPadding(context),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: AppTheme.columnVerticalPaddings(context),
                  child: ProfileFormFields(
                    imagePath: _viewModel.getPickedProfileImagePath(),
                    onPickImage: _viewModel.pickImage,
                    nameController: _viewModel.nameTextController,
                    nameValidator: null,
                    activities: _viewModel.displayActivities,
                    onActivityChanged: (activityName, isSelected) {
                      _viewModel.updateActivitiesByDisplayName(
                        activityName,
                        isSelected,
                      );
                    },
                  ),
                ),
              ),
            ),
            RoundedButton(
              buttonTitle: "Save",
              onPressed: _viewModel.getSaveButtonAction(context),
            ),
          ],
        ),
      ),
    );
  }
}
