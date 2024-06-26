import 'package:bft_clientes/models/setting.dart';
import 'package:bft_clientes/services/controllers/customers_provider.dart';
import 'package:bft_clientes/services/controllers/settings_provider.dart';
import 'package:bft_clientes/services/firebase_services/customers_services.dart';
import 'package:bft_clientes/services/sqflite_services/sqflite_generic_services.dart';
import 'package:bft_clientes/src/constants.dart';
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
  fetchCustomers() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? customersJsonList =
        await FirebaseCustomersServices.fetchCustomers();
    Provider.of<CustomersProvider>(context, listen: false).customersList = Customer.fromJsonList(customersJsonList!);
  }

  loadConfigurations() async {
    List<Setting> settings = await SettingsDao().getAll();
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context, listen: false);

    for (Setting setting in settings) {
      switch (setting.id) {
        case 0: // is_dark_theme
          settingsProvider.appTheme = bool.parse(setting.value) ? darkColorTheme : lightColorTheme;
        case 1: // default_birthday_message
          settingsProvider.defaultBirthdayMessage = setting.value;
      }
    }
    print(settingsProvider.appTheme);
    print(settingsProvider.defaultBirthdayMessage);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchCustomers();
      await loadConfigurations();
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
