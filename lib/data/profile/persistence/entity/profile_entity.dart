import 'package:drift/drift.dart';

class ProfileEntity extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get name => text().withLength(min: 2, max: 255)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (id = 1)'];
}