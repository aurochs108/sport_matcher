import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/ui/core/theme/app_theme.dart';
import 'package:sport_matcher/ui/core/ui/texts/title_medium_text.dart';
import 'profile_screen_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final viewModel = ProfileScreenModel();
  late final Future<ProfileDomain?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = viewModel.loadProfile();
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
                              text: profileName ?? "Missing profile data");
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
