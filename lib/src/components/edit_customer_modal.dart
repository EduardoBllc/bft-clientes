import 'package:bft_clientes/src/components/standard_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../controllers/settings_provider.dart';
import '../../models/color_theme.dart';
import '../../models/customer.dart';

class EditCustomerModal extends StatefulWidget {
  const EditCustomerModal({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  State<EditCustomerModal> createState() => _EditCustomerModalState();
}

class _EditCustomerModalState extends State<EditCustomerModal> {
  late String newName;
  late String newWhatsapp;
  DateTime? newBirthdate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController birthdateController;

  @override
  void initState() {
    birthdateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.customer.birthdate),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context).appTheme;
    return StandardModal(
      maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Editar Dados do Cliente',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: appTheme.fontColor,
                    ),
                  ),
                  Text(
                    '${widget.customer}',
                    style: TextStyle(
                      fontSize: 18,
                      color: appTheme.altSecondaryFontColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      initialValue: widget.customer.name,
                      cursorColor: appTheme.fontColor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        color: appTheme.fontColor,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: appTheme.fontColor,
                        ),
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                          color: appTheme.fontColor,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.secondaryFontColor),
                        ),
                      ),
                      onChanged: (value) {
                        newName = value;
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Digite um nome';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      initialValue: widget.customer.whatsapp,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: appTheme.fontColor,
                      style: TextStyle(
                        color: appTheme.fontColor,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          MdiIcons.whatsapp,
                          color: appTheme.fontColor,
                        ),
                        labelText: 'Whatsapp',
                        labelStyle: TextStyle(
                          color: appTheme.fontColor,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.secondaryFontColor),
                        ),
                      ),
                      onChanged: (value) {
                        newWhatsapp = value;
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Digite um número de whats';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      readOnly: true,
                      cursorColor: appTheme.fontColor,
                      controller: birthdateController,
                      style: TextStyle(
                        color: appTheme.fontColor,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.celebration,
                          color: appTheme.fontColor,
                        ),
                        labelText: 'Data de nascimento',
                        labelStyle: TextStyle(
                          color: appTheme.fontColor,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.fontColor, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: appTheme.secondaryFontColor),
                        ),
                      ),
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          initialDate: widget.customer.birthdate,
                          firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) {
                            if (value != null) {
                              birthdateController.text = DateFormat('dd/MM/yyyy').format(value);
                              newBirthdate = value;
                            }
                          },
                        );
                      },
                      validator: (value) {
                        if (newBirthdate == null) {
                          return 'Escolha a data de aniversário';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: appTheme.primaryButtonStyle.copyWith(
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: const Text(
                        'Salvar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
