import 'dart:io' show Platform;
import 'package:bft_clientes/controllers/messages_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class WeekMessageScreen extends StatelessWidget {
  const WeekMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String providerMessage = Provider.of<MessagesProvider>(context, listen: false).weeklyMessage;

    return Scaffold(
      backgroundColor: kBackgroundColor,
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
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Mensagem Semanal',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: Platform.isIOS ? MediaQuery.sizeOf(context).height * 0.45 : MediaQuery.sizeOf(context).height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade700, width: 4),
                      ),
                      boxShadow: [kBottomBoxShadow],
                      color: Colors.white,
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
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kCreamColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 40,
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade600),
                                foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                                textStyle: const MaterialStatePropertyAll<TextStyle>(
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                elevation: MaterialStateProperty.resolveWith<double>(
                                  (states) => states.contains(MaterialState.pressed) ? 0 : 2,
                                ),
                                shape: MaterialStatePropertyAll<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
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
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(right: 3),
                height: 80,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Clientes selecionados',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text('Todos selecionados'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 75,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(kWeakBrownColor),
                            foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                            textStyle: const MaterialStatePropertyAll<TextStyle>(
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            elevation: MaterialStateProperty.resolveWith<double>(
                              (states) => states.contains(MaterialState.pressed) ? 0 : 2,
                            ),
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Editar'),
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
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                    foregroundColor: MaterialStatePropertyAll<Color>(kWeakBrownColor),
                    textStyle: const MaterialStatePropertyAll<TextStyle>(
                      TextStyle(fontWeight: FontWeight.bold),
                    ),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (states) => states.contains(MaterialState.pressed) ? 0 : 2,
                    ),
                    overlayColor: const MaterialStatePropertyAll<Color>(
                      Colors.black12,
                    ),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
    );
  }
}
