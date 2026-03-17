import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/texts/title_medium_text.dart';
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
                          final profileName = snapshot.data?.name;
                          return TitleMediumText(
                              text: profileName ?? "Missing profile data"); // TODO: add error handling with error logging
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
