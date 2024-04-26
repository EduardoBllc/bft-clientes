import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/customer.dart';
import 'generic_services.dart';

class FirebaseCustomersServices extends FirebaseServices {
  static String tableName = 'clientes';

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetchCustomers() async {
    return await FirebaseServices.getAllCollectionDocs(tableName);
  }

  Future<Customer?> registerCustomer({
    required String name,
    required String whatsapp,
    required DateTime birthdate,
  }) async {
    int? newCustomerId = await getNextCode(tableName);

    Customer newCustomer = Customer.create(
      id: newCustomerId!,
      name: name,
      birthdate: birthdate,
      whatsapp: whatsapp,
    );

    Map<String, dynamic> newCustomerMap = newCustomer.toMap;

    try {
      await firestore.collection(tableName).doc(newCustomerId.toString()).set(newCustomerMap);
      await stepInCode(tableName);
      return newCustomer;
    } on FirebaseException catch (e) {
      log('Erro ao cadastrar peça na Firestore');
      firebaseErrorLogger(e);
      return null;
    }
  }
}
