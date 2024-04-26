import "package:bft_clientes/src/components/standard_modal.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:provider/provider.dart";

import "../../services/controllers/customers_provider.dart";
import "../../services/controllers/settings_provider.dart";
import "../../models/color_theme.dart";
import "../../models/customer.dart";
import "../constants.dart";
import "../edit_customer_screen.dart";
import "customer_message_modal.dart";

class CustomerModal extends StatelessWidget {
  const CustomerModal(
    this.customer, {
    super.key,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context, listen: false).appTheme;
    return StandardModal(
      maxHeight: MediaQuery.sizeOf(context).height * 0.34,
      topRightButtons: [
        IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(appTheme.secondaryColor),
            elevation: const MaterialStatePropertyAll<double>(10),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditCustomerModal(customer),
              ),
            );
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade200),
            elevation: const MaterialStatePropertyAll<double>(10),
          ),
          onPressed: () {
            Provider.of<CustomersProvider>(context, listen: false).removeCustomer(customer);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Cliente deletado com sucesso'),
              ),
            );
          },
          icon: const Icon(
            Icons.delete_outline,
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (customer.customMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      style: appTheme.primaryButtonStyle,
                      color: appTheme.altBackgroundColor,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
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
                              left: 2,
                              child: Icon(
                                Icons.message,
                                size: 20,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: -2,
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
                Text(
                  customer.name,
                  style: TextStyle(
                    fontSize: 30,
                    color: appTheme.fontColor,
                  ),
                ),
              ],
            ),
            Text(
              '${customer.id}',
              style: TextStyle(
                color: appTheme.altSecondaryFontColor,
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
                  'Whatsapp: ${kCellphoneMask.maskText(customer.whatsapp)}',
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
