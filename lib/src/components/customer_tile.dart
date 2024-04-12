import 'package:bft_clientes/constants.dart';
import 'package:flutter/material.dart';
import '../../models/customer.dart';
import 'customer_message_modal.dart';
import 'customer_modal.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile(
    this.customer, {
    super.key,
    this.messagesScreen = false,
  });

  final Customer customer;
  final bool messagesScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isDismissible: true,
                context: context,
                builder: (context) => CustomerModal(customer),
              );
            },
            child: Material(
              color: appTheme.secondaryColor,
              borderRadius: BorderRadius.circular(10),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(customer.name),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (messagesScreen)
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Material(
              color: appTheme.secondaryColor,
              borderRadius: BorderRadius.circular(10),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom,
                        ),
                        child: MessageEditingCustomerModal(customer),
                      ),
                    );
                  },
                  icon: SizedBox.fromSize(
                    size: const Size.square(30),
                    child: const Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            Icons.message,
                            size: 20,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
