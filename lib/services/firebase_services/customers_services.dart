import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../controllers/customers_provider.dart';
import 'generic_services.dart';

class FirebaseCustomersServices extends FirebaseServices {
  static String collectionName = 'clientes';

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> fetchCustomers() async {
    return await FirebaseServices.getAllCollectionDocs(collectionName);
  }

  Future<void> registerCustomer(
    BuildContext context, {
    required String name,
    required String whatsapp,
    required DateTime birthdate,
  }) async {
    int? newCustomerId = await getNextCode(collectionName);

    Customer newCustomer = Customer.create(
      id: newCustomerId!,
      name: name,
      birthdate: birthdate,
      whatsapp: whatsapp,
    );

    String? serviceAttempt = await registerObject(newCustomer, collectionName);
    if (serviceAttempt != null) throw Exception(serviceAttempt);
    serviceAttempt = await stepInCode(collectionName);
    if (serviceAttempt != null) throw Exception(serviceAttempt);
    Provider.of<CustomersProvider>(context, listen: false).addCustomer(newCustomer);
  }

  Future<String?> editCustomer(
    BuildContext context,
    Customer customer, {
    String? name,
    String? message,
    String? whatsapp,
    DateTime? birthdate,
  }) async {
    try {
      Customer editedCustomer = Provider.of<CustomersProvider>(context, listen: false).editCustomer(
        customer,
        name: name,
        whatsapp: whatsapp,
        birthdate: birthdate,
        message: message,
      );
      await firestore.collection(collectionName).doc(editedCustomer.id.toString()).set(editedCustomer.json);
      return null;
    } on FirebaseException catch (err) {
      String errorMessage = 'Erro ao cadastrar cliente na Firestore';
      log(errorMessage);
      firebaseErrorLogger(err);
      return errorMessage;
    }
  }
}
