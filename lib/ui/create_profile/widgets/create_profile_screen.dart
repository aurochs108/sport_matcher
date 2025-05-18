import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';
import 'package:sport_matcher/ui/create_profile/widgets/create_profile_screen_model.dart';

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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create profile"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            PlainTextField(
              keyboardType: TextInputType.emailAddress,
              controller: widget._viewModel.nameTextController,
              title: "Name",
              validator: widget._viewModel.nameValidator,
            ),
          ],
        ),
      ),
    );
  }
}
