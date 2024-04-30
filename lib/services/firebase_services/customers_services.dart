import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../controllers/customers_provider.dart';
import 'generic_services.dart';

class FirebaseCustomersServices extends FirebaseServices {
  static String tableName = 'clientes';

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetchCustomers() async {
    return await FirebaseServices.getAllCollectionDocs(tableName);
  }

  Future<String?> registerCustomer(
    BuildContext context, {
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

    try {
      await firestore.collection(tableName).doc(newCustomerId.toString()).set(newCustomer.json);
      await stepInCode(tableName);
      Provider.of<CustomersProvider>(context, listen: false).addCustomer(newCustomer);
      return null;
    } on FirebaseException catch (err) {
      String errorMessage = 'Erro ao cadastrar cliente na Firestore';
      log(errorMessage);
      firebaseErrorLogger(err);
      return errorMessage;
    }
  }
}
