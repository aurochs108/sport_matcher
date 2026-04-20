import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

class MockSharedPreferencesStore extends InMemorySharedPreferencesStore {
  MockSharedPreferencesStore() : super.empty();

  bool failSetValue = false;

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    if (failSetValue) {
      return false;
    }
    return super.setValue(valueType, key, value);
  }
}
