import 'package:bft_clientes/controllers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';
import 'components/create_customer_modal.dart';
import 'components/customer_tile.dart';
import 'constants.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({
    super.key,
    this.createCustomer = false,
  });

  final bool createCustomer;

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<Customer>? filteredCustomersList;

  Future<Customer?> createCustomerModal() async {
    return await showModalBottomSheet<Customer>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const CreateCustomerModal(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.createCustomer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        createCustomerModal().then((customer) {
          if (customer != null) {
            setState(() {
              Provider.of<CustomersProvider>(context, listen: false).customersList.add(customer);
              filteredCustomersList = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cliente cadastrado com sucesso'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Customer> customersList = Provider.of<CustomersProvider>(context).customersList;
    filteredCustomersList ??= List.from(customersList);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: kDefaultAppBar,
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: const Color(0xff886a4a),
            onPressed: () async {
              createCustomerModal().then((customer) {
                if (customer != null) {
                  setState(() {
                    Provider.of<CustomersProvider>(context, listen: false).customersList.add(customer);
                    filteredCustomersList = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cliente cadastrado com sucesso'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        },
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Material(
              color: kWeakBrownColor,
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Center(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Pesquisar por nome',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredCustomersList = customersList
                            .where((customer) => customer.name.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredCustomersList!.length,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) => CustomerTile(filteredCustomersList![index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
