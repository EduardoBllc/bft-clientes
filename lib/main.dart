import 'package:bft_clientes/services/controllers/messages_provider.dart';
import 'package:bft_clientes/services/controllers/settings_provider.dart';
import 'package:bft_clientes/src/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/controllers/customers_provider.dart';

void main() async {
  runApp(const CustomersManager());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class CustomersManager extends StatelessWidget {
  const CustomersManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomersProvider()),
        ChangeNotifierProvider(create: (_) => MessagesProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: GetMaterialApp(
        locale: const Locale('pt', 'BR'),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
