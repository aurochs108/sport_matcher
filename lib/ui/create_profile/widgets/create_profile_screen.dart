import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_screen_view.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';
import 'package:sport_matcher/ui/core/ui/texts/title_medium_text.dart';
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
          title: const Text("Create profile"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: AppTheme.horizontalPadding(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlainTextField(
                  controller: widget._viewModel.nameTextController,
                  title: "Name",
                  validator: widget._viewModel.nameValidator,
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                const TitleMediumText(text: "Select your favorite sports"),
                const SizedBox(height: 16),
                ChipsCollectionView(items: [
                  "Bike",
                  "Climbing",
                  "Football",
                  "Hockey",
                  "Ping Pong",
                  "Running",
                  "Tennis",
                  "Voleyball",
                ]),
                const SizedBox(height: 16),
                RoundedButton(buttonTitle: "Next", onPressed: null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
