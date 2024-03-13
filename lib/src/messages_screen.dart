import 'package:bft_clientes/controllers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import 'components/customer_tile.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Customer> todaysBirthdayCustomerList =
        Provider.of<CustomersProvider>(context, listen: false)
            .customersList
            .where((customer) {
      return customer.todaysBirthday;
    }).toList();

    BoxShadow defaultShadowBox = BoxShadow(
      offset: const Offset(0, 1),
      blurRadius: 3,
      color: const Color(0xff000000).withOpacity(0.1),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF1ECE9),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Barbearia Fernando Teixeira',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'TenorSans',
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.05,
            right: MediaQuery.sizeOf(context).width * 0.05,
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.05,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [defaultShadowBox],
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  child: todaysBirthdayCustomerList.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffad906e),
                                boxShadow: [defaultShadowBox],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(7),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Aniversariantes de hoje',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.all(10),
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemCount: todaysBirthdayCustomerList.length,
                                itemBuilder: (context, index) => CustomerTile(
                                  customer: todaysBirthdayCustomerList[index],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.no_accounts_outlined,
                                size: 130,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.68,
                                child: const Text(
                                  'Não há mensagens para serem enviadas hoje',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [defaultShadowBox],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          boxShadow: [defaultShadowBox],
                        ),
                        child: const Text(
                          'Mensagem que será enviada aos não personalizados:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: TextFormField(
                            autofocus: false,
                            expands: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              filled: false,
                              border: InputBorder.none,
                              hintText:
                                  'Digite aqui a mensagem que será enviada',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        foregroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xff886a4a),
                        ),
                        textStyle: const MaterialStatePropertyAll<TextStyle>(
                          TextStyle(fontWeight: FontWeight.bold),
                        ),
                        elevation: MaterialStateProperty.resolveWith<double>(
                            (states) =>
                                states.contains(MaterialState.pressed) ? 0 : 3),
                        overlayColor: const MaterialStatePropertyAll<Color>(
                            Colors.black12),
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Confirmar Envio'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
