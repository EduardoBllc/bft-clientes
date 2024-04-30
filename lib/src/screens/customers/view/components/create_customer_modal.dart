import 'package:bft_clientes/src/components/standard_modal.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../models/color_theme.dart';
import '../../../../../services/controllers/settings_provider.dart';
import '../../../../../services/firebase_services/customers_services.dart';

class CreateCustomerModal extends StatefulWidget {
  const CreateCustomerModal({super.key});

  @override
  State<CreateCustomerModal> createState() => _CreateCustomerModalState();
}

class _CreateCustomerModalState extends State<CreateCustomerModal> {
  bool isLoading = false;
  late String name;
  late String whatsapp;
  DateTime? birthdate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context).appTheme;
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
                children: isLoading
                    ? [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      ]
                    : [
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
                            controller: whatsappController,
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
                              whatsappController.text = kCellphoneMask.maskText(value);
                              whatsapp = kCellphoneMask.unmaskText(value);
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
                            style: appTheme.primaryButtonStyle.copyWith(
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                String? customerRegister = await FirebaseCustomersServices().registerCustomer(
                                  context,
                                  name: name,
                                  whatsapp: whatsapp,
                                  birthdate: birthdate!,
                                );
                                if (!mounted) return;
                                if (customerRegister != null) {
                                  showAdaptiveDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog.adaptive(
                                      title: Text('Não foi possível cadastrar cliente!'),
                                      content: Text('Por favor, tente novamente e contate o desenvolvedor.'),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Cliente cadastrado com sucesso'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                                setState(() {
                                  isLoading = false;
                                });
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
