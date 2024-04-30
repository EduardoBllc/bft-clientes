import 'package:flutter/cupertino.dart';

import '../../../../models/customer.dart';

class CreatedCustomerProvider extends ChangeNotifier {
  Customer? _createdCustomer;

  Customer? get createdCustomer => _createdCustomer;
  set createdCustomer(Customer? newCustomer) {
    _createdCustomer = newCustomer;
    notifyListeners();
  }
}
