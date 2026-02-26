import 'package:flutter/material.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';

class ProfileScreenModel extends ChangeNotifier {
  final AbstractProfilesRepository _profilesRepository;

  ProfileScreenModel({AbstractProfilesRepository? profilesRepository})
      : _profilesRepository = profilesRepository ?? ProfilesRepository();

  Future<ProfileDomain?> loadProfile() async {
    return await _profilesRepository.loadProfile();
  }
}
