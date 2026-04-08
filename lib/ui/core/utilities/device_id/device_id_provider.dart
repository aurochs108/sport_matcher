import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/abstract_device_id_provider.dart';
import 'package:uuid/uuid.dart';

class DeviceIdProvider implements AbstractDeviceIdProvider {
  static const _key = 'device_id';

  @override
  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing != null) return existing;

    final deviceId = const Uuid().v4();
    await prefs.setString(_key, deviceId);
    return deviceId;
  }
}
