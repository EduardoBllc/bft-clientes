import 'package:bft_clientes/services/controllers/customers_provider.dart';
import 'package:bft_clientes/services/firebase_services/customers_services.dart';
import 'package:bft_clientes/src/screens/main/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  static const route = '/';

  @override
  State<RouterScreen> createState() => _RouterScreenState();
}

class _RouterScreenState extends State<RouterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? customersJsonList =
          await FirebaseCustomersServices.fetchCustomers();
      Provider.of<CustomersProvider>(context, listen: false).customersList = Customer.fromJsonList(customersJsonList!);
      Navigator.pushNamed(context, MainScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
