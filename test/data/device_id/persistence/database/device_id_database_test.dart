import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:sport_matcher/data/device_id/persistence/database/device_id_database.dart';
import 'package:uuid/uuid.dart';

import '../../../../mocks/mock_shared_preferences_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DeviceIdDatabase', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('getDeviceId returns null when no device ID is stored', () async {
      final sut = DeviceIdDatabase(preferences: SharedPreferences.getInstance());
      final result = await sut.getDeviceId();

      expect(result, isNull);
    });

    test('getDeviceId returns stored device ID', () async {
      final deviceId = const Uuid().v4();
      SharedPreferences.setMockInitialValues({
        'device_id': deviceId,
      });
      final sut = DeviceIdDatabase(preferences: SharedPreferences.getInstance());

      final result = await sut.getDeviceId();

      expect(result, deviceId);
    });

    test('saveDeviceId persists device ID under the device_id key', () async {
      final sut = DeviceIdDatabase(preferences: SharedPreferences.getInstance());
      final deviceId = const Uuid().v4();
      await sut.saveDeviceId(deviceId);

      final result = await sut.getDeviceId();

      expect(result, deviceId);
    });

    test('saveDeviceId throws when persistence fails', () async {
      final store = MockSharedPreferencesStore()..failSetValue = true;
      SharedPreferencesStorePlatform.instance = store;
      final sut = DeviceIdDatabase(preferences: SharedPreferences.getInstance());
      final deviceId = const Uuid().v4();

      expect(
        sut.saveDeviceId(deviceId),
        throwsA(
          isA<StateError>().having(
            (error) => error.toString(),
            'message',
            contains('Failed to persist device ID'),
          ),
        ),
      );
    });
  });
}
