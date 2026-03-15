import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';
import 'package:sport_matcher/data/profile/mapper/profile_mapper.dart';

import '../../../random/profile_domain_random.dart';
import '../../../random/profile_entity_data_random.dart';

void main() {
	group('ProfileMapper', () {
		final sut = ProfileMapper();

    // MARK: - toEntity

		test('toEntity maps domain fields to companion values', () {
			final domain = ProfileDomainRandom.random();

			final result = sut.toEntity(domain);

			expect(result.name, Value(domain.name));
			expect(result.profileImagePath, Value(domain.profileImagePath));
			expect(
				result.bike,
				Value(domain.activities[ActivitiesConfig.bike] ?? false),
			);
			expect(
				result.climbing,
				Value(domain.activities[ActivitiesConfig.climbing] ?? false),
			);
			expect(
				result.football,
				Value(domain.activities[ActivitiesConfig.football] ?? false),
			);
			expect(
				result.hockey,
				Value(domain.activities[ActivitiesConfig.hockey] ?? false),
			);
			expect(
				result.pingPong,
				Value(domain.activities[ActivitiesConfig.pingPong] ?? false),
			);
			expect(
				result.running,
				Value(domain.activities[ActivitiesConfig.running] ?? false),
			);
			expect(
				result.tennis,
				Value(domain.activities[ActivitiesConfig.tennis] ?? false),
			);
			expect(
				result.voleyball,
				Value(domain.activities[ActivitiesConfig.voleyball] ?? false),
			);
		});

    // MARK: - toDomain

		test('toDomain maps entity fields to domain values', () {
			final entity = ProfileEntityDataRandom.random();

			final result = sut.toDomain(entity);

			expect(result.name, entity.name);
			expect(result.profileImagePath, entity.profileImagePath);
			expect(result.activities, {
				ActivitiesConfig.bike: entity.bike,
				ActivitiesConfig.climbing: entity.climbing,
				ActivitiesConfig.football: entity.football,
				ActivitiesConfig.hockey: entity.hockey,
				ActivitiesConfig.pingPong: entity.pingPong,
				ActivitiesConfig.running: entity.running,
				ActivitiesConfig.tennis: entity.tennis,
				ActivitiesConfig.voleyball: entity.voleyball,
			});
		});
	});
}
