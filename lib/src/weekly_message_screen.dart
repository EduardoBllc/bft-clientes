import 'dart:io' show Platform;

import 'package:bft_clientes/controllers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

class WeekMessageScreen extends StatelessWidget {
  const WeekMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String providerMessage = Provider.of<MessagesProvider>(context, listen: false).weeklyMessage;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Mensagem Semanal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: appTheme.fontColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: Platform.isIOS
                        ? MediaQuery.sizeOf(context).height * 0.45
                        : MediaQuery.sizeOf(context).height * 0.5,
                    decoration: BoxDecoration(
                      boxShadow: [kBottomBoxShadow],
                      color: appTheme.altBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        top: BorderSide(
                          color: appTheme.altSecondaryColor,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: providerMessage,
                              expands: true,
                              maxLines: null,
                              cursorColor: appTheme.fontColor,
                              style: TextStyle(
                                color: appTheme.fontColor,
                              ),
                              decoration: InputDecoration(
                                filled: false,
                                border: InputBorder.none,
                                hintText: 'Digite aqui a mensagem que será enviada',
                                hintMaxLines: 2,
                                hintStyle: TextStyle(
                                  color: appTheme.secondaryFontColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: appTheme.altSecondaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 40,
                            ),
                            child: ElevatedButton(
                              style: greyButtonStyle,
                              onPressed: () {},
                              child: const Text('Repetir a Anterior'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [kBottomBoxShadow],
                  color: appTheme.altSecondaryColor,
                ),
                padding: const EdgeInsets.only(right: 3),
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Clientes selecionados',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appTheme.fontColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Todos selecionados',
                            style: TextStyle(color: appTheme.fontColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 75,
                        child: ElevatedButton(
                          style: kBrownButtonStyle,
                          onPressed: () {},
                          child: Text(
                            'Editar',
                            style: TextStyle(color: appTheme.secondaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {},
                  style: kBrownButtonStyle,
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
    );
  }
}
