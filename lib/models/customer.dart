class Customer {
  Customer({
    required this.name,
    required this.birthdate,
    required this.whatsapp,
  }) {
    id = actualID;
    actualID++;
  }

  static int actualID = 1;

  late int id;
  String name;
  DateTime birthdate;
  String whatsapp;

  bool get thisMonthsBirthday {
    return birthdate.month == DateTime.now().month;
  }

  bool get todaysBirthday {
    return DateTime.now().difference(birthdate) < const Duration(days: 1);
  }
}
