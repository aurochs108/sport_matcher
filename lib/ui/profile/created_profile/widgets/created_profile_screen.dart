import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/buttons/rounded_button/rounded_button.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_fields_view.dart';
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

  @override
  void initState() {
    super.initState();
    _viewModel.onStateChanged = () {
      setState(() {});
    };
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
          child: FutureBuilder<ProfileDomain?>(
            future: _viewModel.profileFuture,
            builder: (context, snapshot) {
              final profile = snapshot.data;
              final profileName = profile?.name;
              final imagePath = profile?.profileImagePath ?? '';

              final selectedActivities = _viewModel.selectedActivities(profile);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileFieldsView(
                            imagePath: imagePath,
                            profileName: profileName ?? "Missing profile data",
                            selectedActivities: selectedActivities,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RoundedButton(
                    buttonTitle: "Edit",
                    onPressed: _viewModel.getEditButtonAction(
                      profile,
                      Navigator.of(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
