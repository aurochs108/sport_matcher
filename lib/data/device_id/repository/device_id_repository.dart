import 'package:flutter/foundation.dart';
import 'package:sport_matcher/data/device_id/persistence/database/abstract_device_id_database.dart';
import 'package:sport_matcher/data/device_id/persistence/database/device_id_database.dart';
import 'package:sport_matcher/data/device_id/repository/abstract_device_id_repository.dart';
import 'package:uuid/uuid.dart';

abstract interface class DeviceIdGenerator {
  String call();
}

class UuidDeviceIdGenerator implements DeviceIdGenerator {
  const UuidDeviceIdGenerator([this._uuid = const Uuid()]);

  final Uuid _uuid;

  @override
  String call() => _uuid.v4();
}

class DeviceIdRepository implements AbstractDeviceIdRepository {
  final AbstractDeviceIdDatabase _database;
  final DeviceIdGenerator _generateDeviceId;
  Future<String>? _deviceId;

  DeviceIdRepository({
    AbstractDeviceIdDatabase? database,
    DeviceIdGenerator? generateDeviceId,
  })  : _database = database ?? DeviceIdDatabase(),
        _generateDeviceId = generateDeviceId ?? const UuidDeviceIdGenerator();

  @override
  Future<String> getDeviceId() async {
    final cached = _deviceId;
    if (cached != null) return cached;

    final future = _loadOrCreate();
    _deviceId = future;
    try {
      return await future;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('DeviceIdRepository error: $error');
        debugPrint('StackTrace: $stackTrace');
      }
      _deviceId = null;
      rethrow;
    }
  }

  Future<String> _loadOrCreate() async {
    final existing = await _database.getDeviceId();
    if (existing != null) return existing;

    final deviceId = _generateDeviceId();
    await _database.saveDeviceId(deviceId);
    return deviceId;
  }
}
