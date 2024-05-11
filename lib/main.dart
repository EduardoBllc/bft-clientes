import 'package:bft_clientes/services/controllers/messages_provider.dart';
import 'package:bft_clientes/services/controllers/settings_provider.dart';
import 'package:bft_clientes/src/init_router.dart';
import 'package:bft_clientes/src/screens/customers/view/customers_screen.dart';
import 'package:bft_clientes/src/screens/customers/view/edit_customer_screen.dart';
import 'package:bft_clientes/src/screens/main/main_screen.dart';
import 'package:bft_clientes/src/screens/settings/settings_screen.dart';
import 'package:bft_clientes/src/screens/weekly_message/weekly_message_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/controllers/customers_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const CustomersManager());
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
          colorScheme: ColorScheme.fromSwatch(backgroundColor: Colors.white, primarySwatch: Colors.brown),
        ),
        initialRoute: RouterScreen.route,
        routes: {
          RouterScreen.route: (context) => const RouterScreen(),
          MainScreen.route: (context) => const MainScreen(),
          SettingsScreen.route: (context) => const SettingsScreen(),
          WeekMessageScreen.route: (context) => const WeekMessageScreen(),
          EditCustomerModal.route: (context) => const EditCustomerModal(),
          CustomersScreen.route: (context) => const CustomersScreen(),
        },
      ),
    );
  }
}
