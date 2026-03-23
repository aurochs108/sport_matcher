import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/profile/create_profile/widgets/create_profile_screen_model.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_form_fields_view.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = CreateProfileScreenModel();

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Create profile"),
        ),
        body: ProfileFormFieldsView(
          buttonTitle: "Next",
          getButtonAction: (formModel) => formModel.getSaveButtonAction(
            viewModel.navigateToHomeAction(Navigator.of(context)),
          ),
        ),
      ),
    );
  }
}
