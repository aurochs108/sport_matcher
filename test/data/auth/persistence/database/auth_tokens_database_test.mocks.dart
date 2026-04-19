import 'dart:async' as _i1;

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i3;

class MockFlutterSecureStorage extends _i3.Mock
    implements _i2.FlutterSecureStorage {
  @override
  _i1.Future<void> write({
    required String? key,
    required String? value,
    _i2.AppleOptions? iOptions,
    _i2.AndroidOptions? aOptions,
    _i2.LinuxOptions? lOptions,
    _i2.WebOptions? webOptions,
    _i2.AppleOptions? mOptions,
    _i2.WindowsOptions? wOptions,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#write, [], {
              #key: key,
              #value: value,
              #iOptions: iOptions,
              #aOptions: aOptions,
              #lOptions: lOptions,
              #webOptions: webOptions,
              #mOptions: mOptions,
              #wOptions: wOptions,
            }),
            returnValue: _i1.Future<void>.value(),
            returnValueForMissingStub: _i1.Future<void>.value(),
          )
          as _i1.Future<void>);
}
