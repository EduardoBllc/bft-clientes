import 'package:bft_clientes/models/utils/mixins/registerable.dart';
import 'package:bft_clientes/services/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Customer implements Registerable {
  @override
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

  factory Customer.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> customerJson) {
    return Customer(
      id: customerJson['id'],
      name: '${customerJson['nome']} ${customerJson['sobrenome']}',
      birthdate: Helper.cloudTimeStampToDateTime(customerJson['data_aniversario']),
      whatsapp: customerJson['whatsapp'],
      registerDate: Helper.cloudTimeStampToDateTime(customerJson['data_cadastro']),
      modifiedDate: Helper.cloudTimeStampToDateTime(customerJson['data_modificacao']),
    );
  }

  static List<Customer> fromJsonList(List<QueryDocumentSnapshot<Map<String, dynamic>>> jsonList) {
    return jsonList.map((item) => Customer.fromJson(item)).toList();
  }

  static Customer generic = Customer(
    id: -1,
    name: '',
    birthdate: DateTime.now(),
    whatsapp: '',
    registerDate: DateTime.now(),
    modifiedDate: DateTime.now(),
  );

  List<String> get _splittedName => name.split(' ');

  String get firstName => _splittedName.first;

  String get lastName => name.replaceAll('$firstName ', '');

  String get formattedBirthdate => DateFormat('dd/MM/yyyy').format(birthdate);

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
  Map<String, dynamic> get json => {
        'id': id,
        'nome': firstName,
        'sobrenome': lastName,
        'whatsapp': whatsapp,
        'mensagem': customMessage ?? '',
        'data_aniversario': birthdate,
        'data_cadastro': registerDate,
        'data_modificacao': modifiedDate,
      };
}
