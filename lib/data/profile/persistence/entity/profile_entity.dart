import 'package:drift/drift.dart';
import 'package:sport_matcher/data/profile/config/profile_config.dart';

class ProfileEntity extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get name => text().withLength(
        min: ProfileConfig.nameMinLength,
        max: ProfileConfig.nameMaxLength,
      )();
  TextColumn get profileImagePath => text()();
  BoolColumn get bike => boolean().withDefault(const Constant(false))();
  BoolColumn get climbing => boolean().withDefault(const Constant(false))();
  BoolColumn get football => boolean().withDefault(const Constant(false))();
  BoolColumn get hockey => boolean().withDefault(const Constant(false))();
  BoolColumn get pingPong => boolean().withDefault(const Constant(false))();
  BoolColumn get running => boolean().withDefault(const Constant(false))();
  BoolColumn get tennis => boolean().withDefault(const Constant(false))();
  BoolColumn get voleyball => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['CHECK (id = 1)'];
}
