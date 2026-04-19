import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockFlutterSecureStorage extends FlutterSecureStorage {
  String? capturedKey;
  String? capturedValue;
  Object? writeError;

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    capturedKey = key;
    capturedValue = value;

    if (writeError != null) {
      throw writeError!;
    }
  }
}
