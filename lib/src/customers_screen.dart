import 'package:bft_clientes/controllers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
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
  List<Customer>? filteredCustomersList;

  Future<Customer?> createCustomerModal() async {
    return await showModalBottomSheet<Customer>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
              Provider.of<CustomersProvider>(context, listen: false)
                  .customersList
                  .add(customer);
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
    List<Customer> customersList =
        Provider.of<CustomersProvider>(context).customersList;
    filteredCustomersList ??= List.from(customersList);

    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.black,
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: const Color(0xff886a4a),
            onPressed: () async {
              createCustomerModal().then((customer) {
                if (customer != null) {
                  setState(() {
                    Provider.of<CustomersProvider>(context, listen: false)
                        .customersList
                        .add(customer);
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
              color: const Color(0xff37363d),
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Center(
                  child: TextField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xFF9f9f9f),
                      ),
                      hintText: 'Pesquisar por nome',
                      hintStyle: TextStyle(color: Color(0xFF9f9f9f)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF707070)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredCustomersList = customersList
                            .where((customer) => customer.name.contains(value))
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
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    CustomerTile(customer: customersList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
