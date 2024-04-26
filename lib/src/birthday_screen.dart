import 'dart:io' show Platform;

import 'package:bft_clientes/controllers/customers_provider.dart';
import 'package:bft_clientes/controllers/messages_provider.dart';
import 'package:bft_clientes/controllers/settings_provider.dart';
import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_theme.dart';
import '../models/customer.dart';
import 'components/customer_tile.dart';

class DailyMessagesScreen extends StatelessWidget {
  const DailyMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context, listen: false).appTheme;

    List<Customer> todaysBirthdayCustomerList =
        Provider.of<CustomersProvider>(context).customersList.where((customer) => customer.todaysBirthday).toList();

    List<Customer> customMessageCustomerList = todaysBirthdayCustomerList
        .where((customer) => customer.customMessage != null && customer.customMessage!.isNotEmpty)
        .toList();

    String defaultMessage = Provider.of<MessagesProvider>(context, listen: false).defaultBirthdayMessage;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Barbearia Fernando Teixeira',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'TenorSans',
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.05,
                  horizontal: MediaQuery.sizeOf(context).width * 0.1,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: appTheme.listBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [kBottomBoxShadow],
                        ),
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: todaysBirthdayCustomerList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appTheme.primaryColor,
                                      boxShadow: [kBottomBoxShadow],
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(7),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: const Text(
                                      'Aniversariantes de hoje',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(10),
                                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                                      itemCount: todaysBirthdayCustomerList.length,
                                      itemBuilder: (context, index) => CustomerTile(
                                        todaysBirthdayCustomerList[index],
                                        messagesScreen: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.no_accounts_outlined,
                                      size: 130,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.68,
                                      child: const Text(
                                        'Não há mensagens para serem enviadas hoje',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          color: appTheme.listBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [kBottomBoxShadow],
                        ),
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        child: customMessageCustomerList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: appTheme.altSecondaryFontColor,
                                      boxShadow: [kBottomBoxShadow],
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(7),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      'Aniversariantes com mensagem personalizada:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: appTheme.fontColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.all(10),
                                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                                      itemCount: customMessageCustomerList.length,
                                      itemBuilder: (context, index) => CustomerTile(
                                        customMessageCustomerList[index],
                                        messagesScreen: true,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.no_accounts_outlined,
                                      size: 130,
                                      color: appTheme.fontColor,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.68,
                                      child: Text(
                                        'Ainda não há aniversariantes de hoje'
                                        ' com mensagem personalidzada',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: appTheme.fontColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [kBottomBoxShadow],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: appTheme.altPrimaryColor,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                boxShadow: [kBottomBoxShadow],
                              ),
                              child: Text(
                                'Mensagem que será enviada aos não personalizados:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: appTheme.altFontColor,
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
                                  initialValue: defaultMessage,
                                  decoration: InputDecoration(
                                    filled: false,
                                    border: InputBorder.none,
                                    hintText: 'Digite aqui a mensagem que será enviada',
                                    hintMaxLines: 2,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: appTheme.altBackgroundColor,
                boxShadow: [kTopBoxShadow],
              ),
              padding: Platform.isIOS ? const EdgeInsets.only(top: 15) : const EdgeInsets.symmetric(vertical: 15),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: appTheme.primaryButtonStyle.copyWith(
                          shape: MaterialStatePropertyAll<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Confirmar Envio',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
