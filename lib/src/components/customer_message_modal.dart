import 'package:bft_clientes/controllers/customers_provider.dart';
import 'package:bft_clientes/src/components/standard_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/customer.dart';
import '../constants.dart';

class MessageEditingCustomerModal extends StatefulWidget {
  const MessageEditingCustomerModal(
    this.customer, {
    super.key,
  });

  final Customer customer;

  @override
  State<MessageEditingCustomerModal> createState() => _MessageEditingCustomerModalState();
}

class _MessageEditingCustomerModalState extends State<MessageEditingCustomerModal> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    List<Customer> providerCustomersList = Provider.of<CustomersProvider>(context, listen: false).customersList;
    Customer providerCustomer = providerCustomersList[providerCustomersList.indexOf(widget.customer)];
    if (providerCustomer.customMessage != null && providerCustomer.customMessage!.isNotEmpty) {
      messageController.text = providerCustomer.customMessage!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: StandardModal(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/avatar_default.png',
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              Text(
                widget.customer.name,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [kBottomBoxShadow],
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
                        boxShadow: [kBottomBoxShadow],
                      ),
                      child: const Text(
                        'Mensagem personalizada do cliente:',
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
                          controller: messageController,
                          decoration: InputDecoration(
                            filled: false,
                            border: InputBorder.none,
                            hintText: 'Digite aqui a mensagem personalizada que'
                                ' deseja enviar para este cliente',
                            hintMaxLines: 2,
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
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<CustomersProvider>(context, listen: false).changeCustomerMessage(widget.customer, messageController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        dismissDirection: DismissDirection.horizontal,
                        margin: EdgeInsets.symmetric(
                          vertical: 80,
                          horizontal: 10,
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Messagem salva com sucesso.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                    foregroundColor: const MaterialStatePropertyAll<Color>(
                      Color(0xff886a4a),
                    ),
                    textStyle: const MaterialStatePropertyAll<TextStyle>(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (states) => states.contains(MaterialState.pressed) ? 0 : 2,
                    ),
                    overlayColor: const MaterialStatePropertyAll<Color>(
                      Colors.black12,
                    ),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Salvar mensagem',
                    style: TextStyle(
                      fontSize: 17,
                    ),
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
