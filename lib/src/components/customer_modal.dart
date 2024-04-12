import "package:bft_clientes/src/components/standard_modal.dart";
import "package:bft_clientes/src/constants.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";

import "../../models/customer.dart";

class CustomerModal extends StatelessWidget {
  const CustomerModal(
    this.customer, {
    super.key,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return StandardModal(
      maxHeight: MediaQuery.sizeOf(context).height * 0.27,
      topRightButtons: [
        IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(appTheme.secondaryColor),
            elevation: const MaterialStatePropertyAll<double>(10),
          ),
          onPressed: () {},
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade200),
            elevation: const MaterialStatePropertyAll<double>(10),
          ),
          onPressed: () {},
          icon: Icon(
            Icons.delete_outline,
            color: appTheme.altBackgroundColor,
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              customer.name,
              style: TextStyle(
                fontSize: 30,
                color: appTheme.fontColor,
              ),
            ),
            Text(
              '${customer.id}',
              style: TextStyle(
                color: appTheme.altFontColor,
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
                const SizedBox(width: 5),
                Text(
                  'Whatsapp: ${customer.whatsapp}',
                  style: TextStyle(
                    fontSize: 16,
                    color: appTheme.fontColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(customer.birthdate)}',
              style: TextStyle(
                fontSize: 16,
                color: appTheme.fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
