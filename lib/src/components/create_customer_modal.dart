import 'package:bft_clientes/src/components/standard_modal.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/customer.dart';

class CreateCustomerModal extends StatefulWidget {
  const CreateCustomerModal({super.key});

  @override
  State<CreateCustomerModal> createState() => _CreateCustomerModalState();
}

class _CreateCustomerModalState extends State<CreateCustomerModal> {
  late String name;
  late String whatsapp;
  DateTime? birthdate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StandardModal(
      maxHeight: MediaQuery.sizeOf(context).height * 0.5,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  'Cadastro de Cliente',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: appTheme.fontColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
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
                        name = value;
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
                        whatsapp = value;
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
                          firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) {
                            if (value != null) {
                              birthdateController.text = DateFormat('dd/MM/yyyy').format(value);
                              birthdate = value;
                            }
                          },
                        );
                      },
                      validator: (value) {
                        if (birthdate == null) {
                          return 'Escolha a data de aniversário';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: kBrownButtonStyle,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            Customer(
                              name: name,
                              whatsapp: whatsapp,
                              birthdate: birthdate!,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Cadastrar',
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
