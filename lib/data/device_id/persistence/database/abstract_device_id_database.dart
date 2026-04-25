abstract class AbstractDeviceIdDatabase {
  Future<String?> getDeviceId();
  Future<void> saveDeviceId(String deviceId);
}
