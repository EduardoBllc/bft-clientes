import 'dart:io' show Platform;

import 'package:bft_clientes/src/birthday_screen.dart';
import 'package:bft_clientes/src/components/customer_tile.dart';
import 'package:bft_clientes/src/customers_screen.dart';
import 'package:bft_clientes/src/settings_screen.dart';
import 'package:bft_clientes/src/weekly_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controllers/customers_provider.dart';
import '../models/birthday_options.dart';
import '../models/customer.dart';
import '../constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey birthdayRowKey = GlobalKey();
  late final RenderBox birthdayRowRenderBox;
  double birthdayRowBoxHeight = 70;

  BirthdayOption _birthdayOption = BirthdayOption.day;

  OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  );

  void setSlidingPanelHeight() {
    birthdayRowRenderBox = birthdayRowKey.currentContext!.findRenderObject() as RenderBox;
    birthdayRowBoxHeight = birthdayRowRenderBox.size.height;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setSlidingPanelHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defTextStyle = TextStyle(
      fontSize: 22,
      color: kFontColor,
    );

    TextStyle defSmallTextSyle = defTextStyle.copyWith(fontSize: 14);

    List<Customer> customersList = Provider.of<CustomersProvider>(context).customersList;

    List<Customer> filteredCustomerList = [];

    void getFilteredCustomerList(bool Function(Customer element) test) {
      filteredCustomerList = customersList.where(test).toList();
    }

    ButtonStyle lightenButtonStyle = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(kAltPrimaryColor),
      shape: MaterialStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );

    switch (_birthdayOption) {
      case BirthdayOption.month:
        getFilteredCustomerList((customer) => customer.thisMonthsBirthday);
        break;
      case BirthdayOption.week:
        getFilteredCustomerList((customer) => customer.thisWeekBirthday);
        break;
      case BirthdayOption.day:
        getFilteredCustomerList((customer) => customer.todaysBirthday);
        break;
    }

    Color fontColor = const Color(0xFFD8D9D7);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: kDefaultAppBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              40,
              20,
              40,
              MediaQuery.sizeOf(context).height * 0.2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.fromSize(
                        size: Size.square(
                          MediaQuery.sizeOf(context).width * 0.35,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => const CustomersScreen(createCustomer: true),
                              transition: Transition.rightToLeft,
                            );
                          },
                          style: lightenButtonStyle,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_add_alt_1,
                                color: kFontColor,
                                size: 55,
                              ),
                              Text(
                                'Cadastrar novo cliente',
                                textAlign: TextAlign.center,
                                style: defSmallTextSyle,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: Size.square(
                          MediaQuery.sizeOf(context).width * 0.35,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => const CustomersScreen(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          style: lightenButtonStyle,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.groups,
                                color: kFontColor,
                                size: 55,
                              ),
                              Text(
                                'Todos Clientes',
                                textAlign: TextAlign.center,
                                style: defSmallTextSyle,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.13,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => const WeekMessageScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    style: lightenButtonStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_note,
                          color: kFontColor,
                          size: 60,
                        ),
                        Expanded(
                          child: Text(
                            'Mensagem da semana',
                            textAlign: TextAlign.center,
                            style: defTextStyle,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.13,
                  child: ElevatedButton(
                    style: lightenButtonStyle.copyWith(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xFF888C8C),
                      ),
                    ),
                    onPressed: () {
                      Get.to(
                        () => const DailyMessagesScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Aniversariantes',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: Platform.isIOS ? 24 : 26,
                              color: kAltFontColor,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.celebration,
                          color: kAltFontColor,
                          size: 60,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.14,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => const SettingsScreen(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    style: lightenButtonStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: kFontColor,
                          size: 60,
                        ),
                        Expanded(
                          child: Text(
                            'Configurações',
                            textAlign: TextAlign.center,
                            style: defTextStyle,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Platform.isIOS ? 130 : 110),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.btt,
                baseColor: fontColor.withOpacity(0.5),
                highlightColor: fontColor.withOpacity(0.2),
                period: const Duration(seconds: 5),
                child: const Icon(
                  Icons.keyboard_double_arrow_up,
                  size: 35,
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            backdropEnabled: true,
            color: kAltPrimaryColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            minHeight: Platform.isIOS ? 110 : 100,
            maxHeight: filteredCustomerList.isNotEmpty
                ? (birthdayRowBoxHeight + (Platform.isIOS ? 80 : 50)) + (80 * filteredCustomerList.length).clamp(80, 300)
                : (birthdayRowBoxHeight + 30) + (Platform.isIOS ? 260 : 230),
            panel: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 62,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF888C8C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          key: birthdayRowKey,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Aniversariantes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: kFontColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [kBottomBoxShadow],
                              ),
                              child: DropdownButtonFormField<BirthdayOption>(
                                value: BirthdayOption.day,
                                items: BirthdayOption.values
                                    .map(
                                      (option) => DropdownMenuItem<BirthdayOption>(
                                        value: option,
                                        child: Text(
                                          option.text,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: kPrimaryColor,
                                  border: defaultBorder,
                                  focusedBorder: defaultBorder,
                                  enabledBorder: defaultBorder,
                                ),
                                onChanged: (option) {
                                  setState(() {
                                    if (option != null) {
                                      _birthdayOption = option;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        filteredCustomerList.isNotEmpty
                            ? Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: Platform.isIOS ? 30 : 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                                      itemCount: filteredCustomerList.length,
                                      itemBuilder: (context, index) => CustomerTile(
                                        filteredCustomerList[index],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: Platform.isIOS ? 25 : 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.no_accounts_outlined,
                                      size: 130,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width * 0.72,
                                      child: Text(
                                        'Não há clientes aniversariantes ${_birthdayOption.emptyText}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
