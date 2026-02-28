import 'package:drift/drift.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';

class ProfileEntity extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get name => text().withLength(
    min: ProfileConfig.nameMinLength,
    max: ProfileConfig.nameMaxLength,
  )();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (id = 1)'];
}