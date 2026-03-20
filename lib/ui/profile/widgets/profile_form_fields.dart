import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_screen_view.dart';
import 'package:sport_matcher/ui/core/ui/text_fields/plain_text_field.dart';
import 'package:sport_matcher/ui/core/ui/texts/title_medium_text.dart';
import 'package:sport_matcher/ui/core/utilities/validators/abstract_text_validator.dart';
import 'package:sport_matcher/ui/profile/profile_photo/widgets/profile_photo_screen.dart';

class ProfileFormFields extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPickImage;
  final TextEditingController nameController;
  final AbstractTextValidator? nameValidator;
  final Map<String, bool> activities;
  final void Function(String, bool) onActivityChanged;

  const ProfileFormFields({
    super.key,
    required this.imagePath,
    required this.onPickImage,
    required this.nameController,
    required this.nameValidator,
    required this.activities,
    required this.onActivityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppTheme.columnSpacingMedium,
      children: [
        Center(child: _photoPlaceholder()),
        PlainTextField(
          controller: nameController,
          title: "Name",
          validator: nameValidator,
          textCapitalization: TextCapitalization.words,
          autocorrect: false,
          enableSuggestions: false,
        ),
        const TitleMediumText(text: "Select your favorite sports"),
        ChipsCollectionView(
          items: activities,
          onSelectionChanged: onActivityChanged,
        ),
      ],
    );
  }

  Widget _photoPlaceholder() {
    Widget content;
    if (imagePath case final path?) {
      content = ProfilePhotoView(imagePath: path);
    } else {
      content = Padding(
        padding: const EdgeInsets.all(24.0),
        child: SvgPicture.asset(
          'lib/ui/profile/create_profile/assets/photo_placeholder.svg',
          fit: BoxFit.contain,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: OutlinedButton(
          onPressed: onPickImage,
          style: OutlinedButton.styleFrom(
            padding: imagePath == null
                ? const EdgeInsets.all(48)
                : EdgeInsets.zero,
            side: BorderSide(color: AppTheme.primaryColor, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size.zero,
          ),
          child: content,
        ),
      ),
    );
  }
}
