import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color kBackgroundColor = const Color(0xFFF1ECE9);

Color kCreamColor = const Color(0xffe8e1d8);

Color kWeakBrownColor = const Color(0xffad906e);

Offset kBottomOffset = const Offset(0, 2);
Offset kTopOffset = const Offset(0, -2);

Color kWeakShadowColor = const Color(0xff000000).withOpacity(0.1);

BoxShadow kBottomBoxShadow = BoxShadow(
  offset: kBottomOffset,
  blurRadius: 2,
  color: kWeakShadowColor,
);

BoxShadow kTopBoxShadow = BoxShadow(
  offset: kTopOffset,
  blurRadius: 2,
  color: kWeakShadowColor,
);

AppBar kDefaultAppBar = AppBar(
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
    ),
  ),
);

Scaffold kUnderDevelopmentScreen = Scaffold(
  appBar: kDefaultAppBar,
  body: const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Icon(
        Icons.construction,
        size: 60,
      ),
      Text(
        'Tela em construção',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    ],
  ),
);
