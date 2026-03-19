import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button.dart';
import 'package:sport_matcher/ui/core/ui/collections/chips_screen_view.dart';
import 'package:sport_matcher/ui/core/ui/texts/title_medium_text.dart';
import 'package:sport_matcher/ui/profile/edit_profile/widgets/edit_profile_screen.dart';
import 'package:sport_matcher/ui/profile/profile_photo/widgets/profile_photo_screen.dart';
import 'created_profile_screen_model.dart';

class CreatedProfileScreen extends StatefulWidget {
  const CreatedProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreatedProfileScreenState();
  }
}

class _CreatedProfileScreenState extends State<CreatedProfileScreen> {
  final _viewModel = CreatedProfileScreenModel();
  late final Future<ProfileDomain?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _viewModel.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Profile"),
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
                      FutureBuilder<ProfileDomain?>(
                        future: _profileFuture,
                        builder: (context, snapshot) {
                          final profile = snapshot.data;
                          final profileName = profile?.name;
                          final imagePath = profile?.profileImagePath ?? '';

                          final selectedActivities =
                              _viewModel.selectedActivities(profile);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: ProfilePhotoView(imagePath: imagePath),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TitleMediumText(
                                  text: profileName ?? "Missing profile data"),
                              const SizedBox(height: 12),
                              ChipsCollectionView(
                                items: selectedActivities,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              RoundedButton(
                buttonTitle: "Update",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
