import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/profile/created_profile/widgets/created_profile_screen_model.dart';

import '../../../../random/profile_domain_random.dart';
import 'created_profile_screen_model_test.mocks.dart';

@GenerateMocks([AbstractProfilesRepository])
void main() {
  group('CreatedProfileScreenModel', () {
    late MockAbstractProfilesRepository mockProfilesRepository;
    late CreatedProfileScreenModel sut;

    setUp(() {
      mockProfilesRepository = MockAbstractProfilesRepository();
      sut = CreatedProfileScreenModel(profilesRepository: mockProfilesRepository);
    });

    test('loadProfile returns profile from repository', () async {
      // given
      final expectedProfile = ProfileDomainRandom.random();
      when(mockProfilesRepository.loadProfile())
          .thenAnswer((_) async => expectedProfile);

      // when
      final profile = await sut.loadProfile();

      // then
      expect(profile?.name, expectedProfile.name);
      verify(mockProfilesRepository.loadProfile()).called(1);
    });

    test('loadProfile returns null when repository has no profile', () async {
      // given
      when(mockProfilesRepository.loadProfile()).thenAnswer((_) async => null);

      // when
      final profile = await sut.loadProfile();

      // then
      expect(profile, isNull);
      verify(mockProfilesRepository.loadProfile()).called(1);
    });
  });
}
