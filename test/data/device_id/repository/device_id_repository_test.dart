import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/device_id/persistence/database/abstract_device_id_database.dart';
import 'package:sport_matcher/data/device_id/repository/device_id_repository.dart';
import 'package:uuid/uuid.dart';

import 'device_id_repository_test.mocks.dart';

@GenerateMocks([AbstractDeviceIdDatabase, DeviceIdGenerator])
void main() {
  group('DeviceIdRepository', () {
    late MockAbstractDeviceIdDatabase database;
    late MockDeviceIdGenerator generateDeviceId;
    late DeviceIdRepository sut;

    setUp(() {
      database = MockAbstractDeviceIdDatabase();
      generateDeviceId = MockDeviceIdGenerator();
      sut = DeviceIdRepository(
        database: database,
        generateDeviceId: generateDeviceId,
      );
    });

    test(
      'getDeviceId returns stored device ID without creating a new one',
      () async {
        final storedDeviceId = const Uuid().v4();
        when(database.getDeviceId()).thenAnswer((_) async => storedDeviceId);

        final result = await sut.getDeviceId();

        expect(result, storedDeviceId);
        verify(database.getDeviceId()).called(1);
        verifyNever(database.saveDeviceId(any));
        verifyNever(generateDeviceId());
      },
    );

    test(
      'getDeviceId generates and saves a device ID when none exists',
      () async {
        final generatedDeviceId = const Uuid().v4();
        when(database.getDeviceId()).thenAnswer((_) async => null);
        when(generateDeviceId()).thenReturn(generatedDeviceId);
        when(
          database.saveDeviceId(generatedDeviceId),
        ).thenAnswer((_) async {});

        final result = await sut.getDeviceId();

        expect(result, generatedDeviceId);
        verify(database.getDeviceId()).called(1);
        verify(generateDeviceId()).called(1);
        verify(database.saveDeviceId(generatedDeviceId)).called(1);
      },
    );

    test(
      'getDeviceId returns cached value on repeated successful calls',
      () async {
        final storedDeviceId = const Uuid().v4();
        when(database.getDeviceId()).thenAnswer((_) async => storedDeviceId);

        final first = await sut.getDeviceId();
        final second = await sut.getDeviceId();

        expect(first, storedDeviceId);
        expect(second, storedDeviceId);
        verify(database.getDeviceId()).called(1);
        verifyNever(database.saveDeviceId(any));
        verifyNever(generateDeviceId());
      },
    );

    test('getDeviceId reuses the in-flight future while loading', () async {
      final storedDeviceId = const Uuid().v4();
      final completer = Completer<String?>();
      when(database.getDeviceId()).thenAnswer((_) => completer.future);

      final first = sut.getDeviceId();
      final second = sut.getDeviceId();

      verify(database.getDeviceId()).called(1);
      completer.complete(storedDeviceId);

      expect(await first, storedDeviceId);
      expect(await second, storedDeviceId);
      verifyNever(database.saveDeviceId(any));
      verifyNever(generateDeviceId());
    });
  });
}
