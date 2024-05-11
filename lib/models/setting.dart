class Setting {
  static int actualId = 0;

  late final int id;
  final String description;
  final SettingType type;
  dynamic value;

  Setting({
    required this.id,
    required this.description,
    required this.type,
    required this.value,
  });

  factory Setting.fromDbObject(Map object) {
    return Setting(
      id: object['id'],
      description: object['description'],
      type: SettingType.values.firstWhere((type) => type.value == object['type']),
      value: object['value'],
    );
  }

  static List<Setting> fromDbObjectList(List<Map> objectList) {
    return objectList.map((object) => Setting.fromDbObject(object)).toList();
  }

  Map get dbObject => {
        'id': id,
        'description': description,
        'type': type.name,
        'value': value,
      };

  String get insertValues => "($id, '$description', '${type.value}', '$value')";
}

enum SettingType {
  string('S'),
  int('I'),
  bool('B'),
  double('D');

  const SettingType(this.value);

  final String value;
}
