import 'package:bft_clientes/src/constants.dart';
import 'package:bft_clientes/src/screens/customers/view/components/customer_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/color_theme.dart';
import '../../../../models/customer.dart';
import '../../../../services/controllers/customers_provider.dart';
import '../../../../services/controllers/settings_provider.dart';

class EditCustomerModal extends StatefulWidget {
  const EditCustomerModal({super.key});

  static const route = '/edit_customer';

  @override
  State<EditCustomerModal> createState() => _EditCustomerModalState();
}

class _EditCustomerModalState extends State<EditCustomerModal> {
  bool isLoading = true;

  Customer customer = Customer.generic;
  String? newName;
  String? newWhatsapp;
  String? newMessage;
  DateTime? newBirthdate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();

  @override
  void initState() {
    super.initState();
    birthdateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(customer.birthdate),
    );
    whatsappController = TextEditingController(
      text: kCellphoneMask.maskText(customer.whatsapp),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
        customer = ModalRoute.of(context)?.settings.arguments as Customer;
        nameController.text = customer.name;
        whatsappController.text = kCellphoneMask.maskText(customer.whatsapp);
        birthdateController.text = customer.formattedBirthdate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context, listen: false).appTheme;
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: defaultAppBar(
        context,
        onReturnPressed: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => CustomerModal(customer),
          );
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
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
                                    '${customer}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: appTheme.altSecondaryFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  child: TextFormField(
                                    controller: nameController,
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
                                      if (newWhatsapp == null) {
                                        setState(() {
                                          newName = value;
                                        });
                                      } else {
                                        newName = value;
                                      }
                                    },
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Digite um nome';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 70,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  child: TextFormField(
                                    controller: whatsappController,
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
                                      if (newWhatsapp == null) {
                                        setState(() {
                                          newWhatsapp = kCellphoneMask.unmaskText(value);
                                        });
                                      } else {
                                        newWhatsapp = value;
                                      }
                                    },
                                    validator: (value) {
                                      if (value != null) {
                                        if (value.isEmpty) {
                                          return 'Insira um número de Whatsapp!';
                                        } else if (kCellphoneMask.unmaskText(value).length < 11) {
                                          return 'Digite um número de Whatsapp válido!';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 70,
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
                                        initialDate: customer.birthdate,
                                        firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                                        lastDate: DateTime.now(),
                                      ).then(
                                        (value) {
                                          if (value != null) {
                                            birthdateController.text = DateFormat('dd/MM/yyyy').format(value);
                                            if (newBirthdate == null) {
                                              setState(() {
                                                newBirthdate = value;
                                              });
                                            } else {
                                              newBirthdate = value;
                                            }
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Container(
                                  height: 250,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [kBottomBoxShadow],
                                    color: Colors.grey.shade100,
                                    border: !appTheme.isDarkTheme
                                        ? Border.all(
                                            color: Colors.grey,
                                            width: 0.3,
                                          )
                                        : null,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
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
                                            initialValue: customer.customMessage,
                                            cursorColor: Colors.black,
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
                                            onChanged: (text) {
                                              newMessage = text;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 110,
                          child: ElevatedButton(
                            style: appTheme.altSecondaryButtonStyle.copyWith(
                              shape: MaterialStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => CustomerModal(customer),
                              );
                            },
                            child: const Text(
                              'Cancelar',
                            ),
                          ),
                        ),
                        if (newName != null || newBirthdate != null || newWhatsapp != null)
                          Container(
                            margin: const EdgeInsets.only(left: 20),
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
                                if (formKey.currentState!.validate()) {
                                  Provider.of<CustomersProvider>(context, listen: false).editCustomer(
                                    customer,
                                    name: newName,
                                    whatsapp: newWhatsapp,
                                    birthdate: newBirthdate,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text('Cliente alterado com sucesso!'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => CustomerModal(customer),
                                  );
                                }
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
