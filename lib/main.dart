import 'package:bft_clientes/src/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'controllers/customers_provider.dart';

void main() {
  runApp(const CustomersManager());
}

class CustomersManager extends StatelessWidget {
  const CustomersManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomersProvider()),
      ],
      child: GetMaterialApp(
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
