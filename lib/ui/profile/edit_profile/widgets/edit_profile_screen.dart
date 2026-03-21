import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_view.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileDomain profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _viewModel = ProfileFormFieldsScreenModel();

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
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: ProfileFormFieldsView(
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
        buttonTitle: "Save",
        onButtonPressed: () {
          _viewModel.saveProfile().then((_) {
            navigator.pop();
          });
        },
      ),
    );
  }
}
