import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
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
          title: Text("Create profile"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: AppTheme.horizontalPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppTheme.columnSpacingMedium,
            children: [
              PlainTextField(
                keyboardType: TextInputType.emailAddress,
                controller: widget._viewModel.nameTextController,
                title: "Name",
                validator: widget._viewModel.nameValidator,
              ),
              TitleMediumText(text: "Select your favorite sports"),
              Expanded(
                child: Center(
                  child: ChipsCollectionView(items: [
                    "Bike",
                    "Hockey",
                    "Football",
                    "Climbing",
                    "Ping Pong",
                    "Voleyball",
                    "Tennis",
                    "Running"
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
