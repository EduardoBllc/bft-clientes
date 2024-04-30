import 'package:bft_clientes/services/controllers/customers_provider.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/color_theme.dart';
import '../../../../models/customer.dart';
import '../../../../services/controllers/settings_provider.dart';
import '../../../../services/firebase_services/customers_services.dart';
import 'components/create_customer_modal.dart';
import 'components/customer_tile.dart';

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
  bool isLoading = false;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    filteredCustomersList = List.from(Provider.of<CustomersProvider>(context).customersList);
  }

  @override
  void initState() {
    super.initState();
    if (widget.createCustomer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        createCustomerModal().then((customer) {
          if (customer != null) {
            Provider.of<CustomersProvider>(context, listen: false).customersList.add(customer);
            filteredCustomersList = null;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context, listen: false).appTheme;
    List<Customer> customersList = Provider.of<CustomersProvider>(context).customersList;
    filteredCustomersList ??= List.from(customersList);

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: defaultAppBar(
        context,
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: appTheme.primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
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
          );
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Provider(
              create: (BuildContext context) {},
              child: GestureDetector(
                onTap: () {
                  // Dismiss keyboard
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Material(
                      color: appTheme.altBackgroundColor,
                      elevation: 2,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 80,
                        child: Center(
                          child: TextField(
                            cursorColor: appTheme.fontColor,
                            style: TextStyle(color: appTheme.fontColor),
                            autofocus: false,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: appTheme.fontColor,
                              ),
                              hintText: 'Pesquisar por nome',
                              hintStyle: TextStyle(
                                color: appTheme.fontColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: appTheme.fontColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: appTheme.fontColor,
                                  width: 2,
                                ),
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
                      child: RefreshIndicator(
                        onRefresh: () async {
                          List<QueryDocumentSnapshot<Map<String, dynamic>>>? customersJsonList =
                              await FirebaseCustomersServices.fetchCustomers();
                          Provider.of<CustomersProvider>(context, listen: false).customersList =
                              Customer.fromJsonList(customersJsonList!);
                        },
                        child: ListView.separated(
                          itemCount: filteredCustomersList!.length,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) => CustomerTile(filteredCustomersList![index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
