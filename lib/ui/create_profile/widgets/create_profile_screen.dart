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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PlainTextField(
                        controller: widget._viewModel.nameTextController,
                        title: "Name",
                        validator: widget._viewModel.nameValidator,
                        textCapitalization: TextCapitalization.words,
                      ),
                      const SizedBox(height: AppTheme.columnSpacingMedium),
                      const TitleMediumText(
                          text: "Select your favorite sports"),
                      const SizedBox(height: AppTheme.columnSpacingMedium),
                      ChipsCollectionView(
                        items: widget._viewModel.activities,
                        onSelectionChanged: (activity, isSelected) {
                          widget._viewModel
                              .updateActivites(activity, isSelected);
                        },
                      ),
                      const SizedBox(height: AppTheme.columnSpacingMedium),
                    ],
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
