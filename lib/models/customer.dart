class Customer {
  Customer({
    required this.name,
    required this.birthdate,
    required this.whatsapp,
    this.customMessage,
  }) {
    id = actualID;
    actualID++;
  }

  static int actualID = 1;

  late int id;
  String name;
  DateTime birthdate;
  String whatsapp;
  String? customMessage;

  DateTime get _actualYearBirthdate => DateTime(
        DateTime.now().year,
        birthdate.month,
        birthdate.day,
      );

  bool get thisMonthsBirthday {
    return birthdate.month == DateTime.now().month;
  }

  bool get todaysBirthday {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day) == _actualYearBirthdate;
  }

  bool get thisWeekBirthday {
    int actualWeekDay = DateTime.now().weekday;
    DateTime weekInitialDate =
        DateTime.now().subtract(Duration(days: actualWeekDay));
    DateTime weekEndDate =
        DateTime.now().add(Duration(days: 7 - actualWeekDay - 1));
    return _actualYearBirthdate.isAfter(weekInitialDate) &&
        _actualYearBirthdate.isBefore(weekEndDate);
  }
}
