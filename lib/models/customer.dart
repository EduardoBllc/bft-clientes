import 'package:bft_clientes/models/utils/mixins/registerable.dart';
import 'package:bft_clientes/services/utils.dart';

class Customer implements Registerable {
  final int id;
  String name;
  DateTime birthdate;
  String whatsapp;
  String? customMessage;
  late final DateTime registerDate;
  late DateTime modifiedDate;

  Customer({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.whatsapp,
    required this.registerDate,
    required this.modifiedDate,
    this.customMessage,
  });

  factory Customer.create({
    required int id,
    required String name,
    required DateTime birthdate,
    required String whatsapp,
    String? customMessage,
  }) {
    DateTime registerDate = DateTime.now();
    DateTime modifiedDate = DateTime.now();

    return Customer(
      id: id,
      name: name,
      birthdate: birthdate,
      whatsapp: whatsapp,
      registerDate: registerDate,
      modifiedDate: modifiedDate,
      customMessage: customMessage,
    );
  }

  factory Customer.fromJson(Map customerJson) {
    DateTime datetimeBirthdate = Helper.cloudTimeStampToDateTime(customerJson['data_aniversario']);
    return Customer(
      id: customerJson['id'],
      name: '${customerJson['primeiro_nome']} ${customerJson['sobrenome']}',
      birthdate: datetimeBirthdate,
      whatsapp: customerJson['whatsapp'],
      registerDate: customerJson['data_cadastro'],
      modifiedDate: customerJson['data_modificacao'],
    );
  }

  static List<Customer> fromJsonList(List<Map> jsonList) {
    return jsonList.map((item) => Customer.fromJson(item)).toList();
  }

  List<String> get _splittedName => name.split(' ');

  String get firstName => _splittedName.first;

  String get lastName => name.replaceAll('$firstName ', '');

  DateTime get _actualYearBirthdate => DateTime(
        DateTime.now().year,
        birthdate.month,
        birthdate.day,
      );

  String get dmBirthdate => '${birthdate.day}/${birthdate.month}';

  bool get thisMonthsBirthday {
    return birthdate.month == DateTime.now().month;
  }

  bool get todaysBirthday {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day) == _actualYearBirthdate;
  }

  bool get thisWeekBirthday {
    int actualWeekDay = DateTime.now().weekday;
    DateTime weekInitialDate = DateTime.now().subtract(Duration(days: actualWeekDay));
    DateTime weekEndDate = DateTime.now().add(Duration(days: 7 - actualWeekDay - 1));
    return _actualYearBirthdate.isAfter(weekInitialDate) && _actualYearBirthdate.isBefore(weekEndDate);
  }

  @override
  String toString() => name;

  @override
  String get log => '$name, contato: $whatsapp, aniversário: $dmBirthdate';

  @override
  Map<String, dynamic> get toMap => {
        'id': id,
        'primeiro_nome': firstName,
        'sobrenome': lastName,
        'whatsapp': whatsapp,
        'data_aniversario': birthdate,
      };
}
