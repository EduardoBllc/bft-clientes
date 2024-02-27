import 'package:bft_clientes/src/components/standard_modal.dart';
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
            const SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  'Cadastro de Cliente',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nome',
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.whatsapp),
                        hintText: 'Whatsapp',
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
                      controller: birthdateController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.celebration),
                        hintText: 'Data de nascimento',
                      ),
                      onTap: () async {
                        await showDatePicker(
                          context: context,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 36500)),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) {
                            if (value != null) {
                              birthdateController.text =
                                  DateFormat('dd/MM/yyyy').format(value);
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
                      style: ButtonStyle(
                        elevation:
                            MaterialStateProperty.resolveWith<double>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 2;
                          } else {
                            return 4;
                          }
                        }),
                      ),
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
                        style: TextStyle(color: Colors.black87),
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
