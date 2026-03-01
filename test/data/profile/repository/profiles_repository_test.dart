import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/profile/domain/profile_domain.dart';
import 'package:sport_matcher/data/profile/persistence/database/abstract_profile_database.dart';
import 'package:sport_matcher/data/profile/persistence/database/profile_database.dart';
import 'package:sport_matcher/data/profile/repository/profiles_repository.dart';
import 'package:uuid/uuid.dart';

import 'profiles_repository_test.mocks.dart';

@GenerateMocks([AbstractProfileDatabase])
void main() {
  group('ProfilesRepository', () {
    late MockAbstractProfileDatabase profileDatabase;
    late ProfilesRepository sut;

    setUp(() {
      profileDatabase = MockAbstractProfileDatabase();
      sut = ProfilesRepository(profileDatabase: profileDatabase);
    });

    // MARK: - addProfile

    test('addProfile inserts mapped companion', () async {
      // given
      final profile = ProfileDomain(Uuid().v4().toString());
      when(profileDatabase.insertProfile(any)).thenAnswer((_) async => 1);

      // when
      await sut.addProfile(profile);

      // then
      final captured = verify(profileDatabase.insertProfile(captureAny))
          .captured
          .single as ProfileEntityCompanion;

      final expectedProfile = ProfileEntityCompanion(
        name: Value(profile.name),
      );
      expect(expectedProfile, captured);
    });

    //MARK: - loadProfile

    test('loadProfile returns null when database returns null', () async {
      // given
      when(profileDatabase.loadProfile()).thenAnswer((_) async => null);

      // when
      final result = await sut.loadProfile();

      // then
      expect(result, isNull);
      verify(profileDatabase.loadProfile()).called(1);
    });

    test('loadProfile maps entity to domain when database returns entity',
        () async {
      // given
      final entity = ProfileEntityData(id: 1, name: Uuid().v4().toString());
      when(profileDatabase.loadProfile()).thenAnswer((_) async => entity);

      // when
      final result = await sut.loadProfile();

      // then
      expect(result, isNotNull);
      expect(result!.name, entity.name);
      verify(profileDatabase.loadProfile()).called(1);
    });
  });
}
