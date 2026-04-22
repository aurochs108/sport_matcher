import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sport_matcher/data/device_id/persistence/database/abstract_device_id_database.dart';
import 'package:sport_matcher/data/device_id/repository/device_id_repository.dart';
import 'package:uuid/uuid.dart';

import 'device_id_repository_test.mocks.dart';

@GenerateMocks([AbstractDeviceIdDatabase])
void main() {
  group('DeviceIdRepository', () {
    late MockAbstractDeviceIdDatabase database;
    late DeviceIdRepository sut;

    setUp(() {
      database = MockAbstractDeviceIdDatabase();
      sut = DeviceIdRepository(database: database);
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
      },
    );

    test(
      'getDeviceId generates and saves a device ID when none exists',
      () async {
        when(database.getDeviceId()).thenAnswer((_) async => null);
        when(database.saveDeviceId(any)).thenAnswer((_) async {});

        final result = await sut.getDeviceId();
        final savedDeviceId =
            verify(database.saveDeviceId(captureAny)).captured.single as String;

        expect(result, savedDeviceId);
        expect(Uuid.isValidUUID(fromString: savedDeviceId), isTrue);
        verify(database.getDeviceId()).called(1);
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
    });
  });
}
