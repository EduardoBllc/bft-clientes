import 'package:flutter/material.dart';
import '../../models/customer.dart';
import 'customer_modal.dart';

class CustomerTile extends StatelessWidget {
  const CustomerTile({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) => CustomerModal(
            customer: customer,
          ),
        );
      },
      child: Material(
        type: MaterialType.card,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(customer.name),
          ),
        ),
      ),
    );
  }
}
