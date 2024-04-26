import 'package:bft_clientes/services/firebase_services/customers_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RouterScreen extends StatefulWidget {
  const RouterScreen({super.key});

  static const String id = '/';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
