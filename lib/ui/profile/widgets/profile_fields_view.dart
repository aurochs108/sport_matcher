import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_collection_view.dart';
import 'package:sport_matcher/ui/profile/profile_photo/widgets/profile_photo_screen.dart';

class ProfileFieldsView extends StatelessWidget {
  final String imagePath;
  final String profileName;
  final Map<String, bool> selectedActivities;

  const ProfileFieldsView({
    super.key,
    required this.imagePath,
    required this.profileName,
    required this.selectedActivities,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ProfilePhotoView(imagePath: imagePath),
          ),
        ),
        const SizedBox(height: 12),
        InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          child: Text(
            profileName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 12),
        InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Activities',
            border: InputBorder.none,
          ),
          child: ChipsCollectionView(
            items: {for (final key in selectedActivities.keys) key: false},
          ),
        ),
      ],
    );
  }
}
