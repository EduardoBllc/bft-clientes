import "package:bft_clientes/src/components/standard_modal.dart";
import "package:flutter/material.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "../../models/customer.dart";
import 'package:intl/intl.dart';

class CustomerModal extends StatelessWidget {
  const CustomerModal({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return StandardModal(
      maxHeight: MediaQuery.sizeOf(context).height * 0.45,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/avatar_default.png',
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(
            customer.name,
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            '${customer.id}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.whatsapp,
                color: Colors.greenAccent,
              ),
              const SizedBox(width: 10),
              Text(
                'Whatsapp: ${customer.whatsapp}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(customer.birthdate)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      topRightButton: IconButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(Colors.grey.shade400),
          elevation: const MaterialStatePropertyAll<double>(10),
        ),
        onPressed: () {},
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
