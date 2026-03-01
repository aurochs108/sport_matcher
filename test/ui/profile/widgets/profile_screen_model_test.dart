import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/repository/abstract_profiles_repository.dart';
import 'package:sport_matcher/ui/profile/widgets/profile_screen_model.dart';
import 'package:uuid/uuid.dart';

import 'profile_screen_model_test.mocks.dart';

@GenerateMocks([AbstractProfilesRepository])
void main() {
	group('ProfileScreenModel', () {
		late MockAbstractProfilesRepository mockProfilesRepository;
		late ProfileScreenModel sut;

		setUp(() {
			mockProfilesRepository = MockAbstractProfilesRepository();
			sut = ProfileScreenModel(profilesRepository: mockProfilesRepository);
		});

		test('loadProfile returns profile from repository', () async {
			// given
			final expectedProfileName = const Uuid().v4();
			when(mockProfilesRepository.loadProfile())
					.thenAnswer((_) async => ProfileDomain(expectedProfileName));

			// when
			final profile = await sut.loadProfile();

			// then
			expect(profile?.name, expectedProfileName);
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
