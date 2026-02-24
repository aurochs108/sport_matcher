import 'package:drift/drift.dart';

class ProfileEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2, max: 255)();
}