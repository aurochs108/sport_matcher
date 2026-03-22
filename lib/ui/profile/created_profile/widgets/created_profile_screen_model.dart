import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';
import 'package:sport_matcher/ui/profile/edit_profile/widgets/edit_profile_screen.dart';

class CreatedProfileScreenModel extends ChangeNotifier {
  final AbstractProfilesRepository _profilesRepository;
  late Future<ProfileDomain?> profileFuture;
  Function()? onStateChanged;

  CreatedProfileScreenModel({AbstractProfilesRepository? profilesRepository})
      : _profilesRepository = profilesRepository ?? ProfilesRepository() {
    profileFuture = _loadProfile();
  }

  Future<ProfileDomain?> _loadProfile() async {
    return await _profilesRepository.loadProfile();
  }

  void reloadProfile() {
    profileFuture = _loadProfile();
    onStateChanged?.call();
  }

  Map<String, bool> selectedActivities(ProfileDomain? profile) {
    return Map.fromEntries(
      profile?.activities.entries
              .where((e) => e.value)
              .map((e) => MapEntry(e.key.displayName, true)) ??
          [],
    );
  }

  VoidCallback? getEditButtonAction(
    ProfileDomain? profile,
    NavigatorState navigator,
  ) {
    if (profile == null) return null;

    return () async {
      await navigator.push(
        MaterialPageRoute(
          builder: (_) => EditProfileScreen(profile: profile),
        ),
      );
      reloadProfile();
    };
  }
}
