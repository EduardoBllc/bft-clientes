import 'package:bft_clientes/services/controllers/customers_provider.dart';
import 'package:bft_clientes/src/components/customer_modal.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../services/controllers/settings_provider.dart';
import '../models/color_theme.dart';
import '../models/customer.dart';

class EditCustomerModal extends StatefulWidget {
  const EditCustomerModal(this.customer, {super.key});

  final Customer customer;

  @override
  State<EditCustomerModal> createState() => _EditCustomerModalState();
}

class _EditCustomerModalState extends State<EditCustomerModal> {
  String? newName;
  String? newWhatsapp;
  DateTime? newBirthdate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController birthdateController;
  late TextEditingController whatsappController;

  @override
  void initState() {
    birthdateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.customer.birthdate),
    );
    whatsappController = TextEditingController(
      text: kCellphoneMask.maskText(widget.customer.whatsapp),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context).appTheme;
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: defaultAppBar(
        context,
        onReturnPressed: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            builder: (context) => CustomerModal(widget.customer),
          );
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
              height: MediaQuery.sizeOf(context).height * 0.87 + MediaQuery.viewInsetsOf(context).bottom,
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
                        SizedBox(
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
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.28,
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
                                    initialValue: widget.customer.customMessage,
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
                                    onChanged: (text) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
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
                                    builder: (context) => CustomerModal(widget.customer),
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
                                        widget.customer,
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
                                        builder: (context) => CustomerModal(widget.customer),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
