import 'package:bft_clientes/src/components/customer_tile.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../controllers/customers_provider.dart';
import '../models/customer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Customer> customersList =
        Provider.of<CustomersProvider>(context).customersList;

    return Scaffold(
      backgroundColor: const Color(0xFFF1ECE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Barbearia Fernando Teixeira',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'TenorSans',
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.75,
            ),
            Column(
              children: [
                const Icon(Icons.swipe_up_outlined),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFFAF8F7),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x2f000000),
                        offset: Offset(0, -1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Aniversariantes',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' desta semana:',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          fontFamily: 'Harmattan',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
                            itemCount: customersList.length,
                            itemBuilder: (context, index) =>
                                CustomerTile(customer: customersList[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
