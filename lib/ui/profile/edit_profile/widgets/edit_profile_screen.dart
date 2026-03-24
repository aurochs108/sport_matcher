import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/profile/edit_profile/widgets/edit_profile_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_view.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileDomain profile;

  EditProfileScreen({super.key, required this.profile});

  final _viewModel = EditProfileScreenModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: ProfileFormFieldsView(
        buttonTitle: "Save",
        initialProfile: profile,
        onSaved: () => _viewModel.onSavedAction(Navigator.of(context)),
      ),
    );
  }
}
