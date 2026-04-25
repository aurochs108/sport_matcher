import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_matcher/data/device_id/persistence/database/abstract_device_id_database.dart';

class DeviceIdDatabase implements AbstractDeviceIdDatabase {
  static const _key = 'device_id';

  final Future<SharedPreferences> _preferences;

  DeviceIdDatabase({Future<SharedPreferences>? preferences})
      : _preferences = preferences ?? SharedPreferences.getInstance();

  @override
  Future<String?> getDeviceId() async {
    final preferences = await _preferences;
    return preferences.getString(_key);
  }

  @override
  Future<void> saveDeviceId(String deviceId) async {
    final preferences = await _preferences;
    final saved = await preferences.setString(_key, deviceId);
    if (!saved) {
      throw StateError('Failed to persist device ID');
    }
  }
}
