import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/setting.dart';

const int version = 1;
const String _tableName = 'cofigurations';

final DatabaseColumn _id = DatabaseColumn('id', DataType.integer, primaryKey: true);
final DatabaseColumn _description = DatabaseColumn('description', DataType.integer);
final DatabaseColumn _type = DatabaseColumn('type', DataType.singleChar);
final DatabaseColumn _value = DatabaseColumn('value', DataType.text);

final String tableDeclaration = 'CREATE TABLE $_tableName('
    '${_id.declaration},'
    '${_description.declaration}, '
    '${_type.declaration},'
    '${_value.declaration})';

List<Setting> settingsList = [
  Setting(
    id: 0,
    description: 'Usa tema escuro',
    type: SettingType.bool,
    value: 'true',
  ),
  Setting(
    id: 1,
    description: 'Mensagem de aniversário padrão',
    type: SettingType.string,
    value: 'Teste',
  ),
];

final String settingsDeclaration = 'INSERT INTO $_tableName($_id, $_description, $_type, $_value) '
    'VALUES'
    '${settingsList.fold<String>('', (values, setting) => values = '$values, ${setting.insertValues}').replaceFirst(',', '')};';

Future<Database> getDatabase() async {
  String path = join(await getDatabasesPath(), 'configs.db');
  return openDatabase(path, version: version, onCreate: (db, version) async {
    await db.execute(tableDeclaration);
    await db.execute(settingsDeclaration);
  });
}

class SettingsDao {
  Future<Database> get db async => await getDatabase();

  String get tableName => _tableName;

  String get id => _id.name;
  String get description => _description.name;
  String get type => _type.name;
  String get value => _value.name;

  List<String> get allColumns => [id, description, type, value];

  Future<List<Setting>> getAll() async {
    List<Map> databaseObjects = await (await db).query(tableName, columns: allColumns);
    return Setting.fromDbObjectList(databaseObjects);
  }

  Future<Setting?> get(int id) async {
    List<Map> databaseObject = await (await db).query(tableName, columns: allColumns, where: 'id = $id');
    return Setting.fromDbObject(databaseObject[0]);
  }

  edit(int id) {}
}

class DatabaseColumn {
  final String name;
  final DataType type;
  final bool primaryKey;
  final bool nullable;

  DatabaseColumn(
    this.name,
    this.type, {
    this.nullable = false,
    this.primaryKey = false,
  });

  String get nullableDeclaration => nullable ? '' : 'NOT NULL';

  String get primaryKeyDeclaration => primaryKey ? 'PRIMARY KEY' : '';

  String get declaration => '$name $type $nullableDeclaration $primaryKeyDeclaration';

  @override
  String toString() => name;
}

enum DataType {
  integer('INTEGER'),
  numeric('NUMERIC'),
  real('REAL'),
  text('TEXT'),
  blob('BLOB'),
  singleChar('CHAR(1)');

  final String declaration;

  @override
  String toString() => declaration;

  const DataType(this.declaration);
}
