import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
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
                  child: Padding(
                    padding: AppTheme.columnVerticalPaddings(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppTheme.columnSpacingMedium,
                      children: [
                        Center(
                          child: photoPlaceholder(context),
                        ),
                        PlainTextField(
                          controller: widget._viewModel.nameTextController,
                          title: "Name",
                          validator: widget._viewModel.nameValidator,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const TitleMediumText(
                            text: "Select your favorite sports"),
                        ChipsCollectionView(
                          items: widget._viewModel.activities,
                          onSelectionChanged: (activity, isSelected) {
                            widget._viewModel
                                .updateActivites(activity, isSelected);
                          },
                        ),
                      ],
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

  Widget photoPlaceholder(BuildContext context) {
    final viewModel = widget._viewModel;
    final pickedImagePath = viewModel.getPickedImagePath();
    const double contentSize = 96;
    const double buttonSize = 192;
    Widget content;
    if (pickedImagePath case final imagePath?) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox.expand(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      content = SizedBox(
        width: contentSize,
        child: SvgPicture.asset(
          'lib/ui/create_profile/assets/photo_placeholder.svg',
          fit: BoxFit.contain,
        ),
      );
    }

    return OutlinedButton(
      onPressed: viewModel.pickImage,
      style: OutlinedButton.styleFrom(
        fixedSize: Size(buttonSize, buttonSize),
        padding: pickedImagePath == null
            ? const EdgeInsets.all(48)
            : EdgeInsets.zero,
        side: BorderSide(color: AppTheme.primaryColor, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size.zero,
      ),
      child: content,
    );
  }
}
