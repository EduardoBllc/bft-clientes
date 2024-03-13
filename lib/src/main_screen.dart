import 'package:bft_clientes/src/components/customer_tile.dart';
import 'package:bft_clientes/src/customers_screen.dart';
import 'package:bft_clientes/src/messages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controllers/customers_provider.dart';
import '../models/birthday_options.dart';
import '../models/customer.dart';
import 'components/main_screen_button.dart';
import 'dart:io' show Platform;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey birthdayRowKey = GlobalKey();
  late final RenderBox birthdayRowRenderBox;
  double birthdayRowBoxHeight = 0;

  final GlobalKey revisionButtonKey = GlobalKey();
  late final RenderBox revisionButtonRenderBox;
  double revisionButtonBoxWidth = 0;
  double revisionButtonBoxHeight = 0;
  bool _loading = true;

  BirthdayOption _birthdayOption = BirthdayOption.day;

  OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  );

  void setSlidingPanelHeight() {
    birthdayRowRenderBox =
        birthdayRowKey.currentContext!.findRenderObject() as RenderBox;
    birthdayRowBoxHeight = birthdayRowRenderBox.size.height;
  }

  void setRevisionButtonSizes() {
    revisionButtonRenderBox =
        revisionButtonKey.currentContext!.findRenderObject() as RenderBox;
    revisionButtonBoxWidth = revisionButtonRenderBox.size.width;
    revisionButtonBoxHeight = revisionButtonRenderBox.size.height;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setSlidingPanelHeight();
      setRevisionButtonSizes();
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Customer> customersList =
        Provider.of<CustomersProvider>(context).customersList;

    List<Customer> filteredCustomerList = [];

    void getFilteredCustomerList(bool Function(Customer element) test) {
      filteredCustomerList = customersList.where(test).toList();
    }

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

    BoxShadow defaultShadowBox = BoxShadow(
      offset: const Offset(0, 3),
      blurRadius: 2,
      color: const Color(0xff000000).withOpacity(0.2),
    );

    Divider defaultDivider = const Divider(
      thickness: 1.7,
      height: 30,
      indent: 5,
      endIndent: 5,
    );

    Color fontColor = const Color(0xFF595959);

    return Scaffold(
      backgroundColor: const Color(0xFFF1ECE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Barbearia Fernando Teixeira',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'TenorSans',
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: MainScreenButton(
                    icon: Icons.person_add_alt_1_sharp,
                    text: 'Cadastro de Clientes',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CustomersScreen(
                            createCustomer: true,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                defaultDivider,
                Expanded(
                  child: MainScreenButton(
                    icon: Icons.groups,
                    text: 'Todos Clientes',
                    reverted: true,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CustomersScreen(),
                        ),
                      );
                    },
                  ),
                ),
                defaultDivider,
                Expanded(
                  child: MainScreenButton(
                    icon: Icons.edit_note,
                    text: 'Mensagem da Semana',
                    onPressed: () {},
                  ),
                ),
                defaultDivider,
                SizedBox(
                  key: revisionButtonKey,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll<Color>(
                          Color(0xffe8e1d8)),
                      shape: MaterialStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return 0;
                          }
                          return 3;
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MessagesScreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Revisar Mensagens para Disparo',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 26, color: fontColor),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: revisionButtonBoxWidth * 0.35,
                          height: revisionButtonBoxHeight * 0.6,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Icon(
                                  Icons.message,
                                  color: fontColor,
                                  size: 60,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.check_box,
                                  color: fontColor,
                                  size: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Platform.isIOS ? 10 : 20,
                      bottom: Platform.isIOS ? 50 : 20),
                  child: Icon(
                    Icons.keyboard_double_arrow_up,
                    size: 35,
                    color: fontColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: const Color(0xFFF1ECE9),
              child: const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xff886a4a),
                  ),
                ),
              ),
            ),
          SlidingUpPanel(
            backdropEnabled: true,
            minHeight: Platform.isIOS ? 120 : 100,
            maxHeight: filteredCustomerList.isNotEmpty
                ? (birthdayRowBoxHeight + (Platform.isIOS ? 80 : 50)) +
                    (80 * filteredCustomerList.length).clamp(80, 400)
                : (birthdayRowBoxHeight + 30) + (Platform.isIOS ? 260 : 230),
            color: const Color(0xFFFAF8F7),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
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
                        color: const Color(0xFFD2D1D1),
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
                                fontSize: Platform.isIOS ? 22 : 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                boxShadow: [defaultShadowBox],
                              ),
                              width: MediaQuery.sizeOf(context).width * 0.36,
                              child: DropdownButtonFormField<BirthdayOption>(
                                value: BirthdayOption.day,
                                icon: const SizedBox(),
                                items: BirthdayOption.values
                                    .map(
                                      (option) =>
                                          DropdownMenuItem<BirthdayOption>(
                                        value: option,
                                        child: Text(
                                          option.text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: Platform.isIOS ? 16 : 18,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
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
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 5),
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 10),
                                      itemCount: filteredCustomerList.length,
                                      itemBuilder: (context, index) =>
                                          CustomerTile(
                                        customer: filteredCustomerList[index],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: Platform.isIOS ? 25 : 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.no_accounts_outlined,
                                      size: 130,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.72,
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
