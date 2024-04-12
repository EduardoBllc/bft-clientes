import 'package:bft_clientes/models/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ColorTheme darkColorTheme = ColorTheme(
//   backgroundColor: const Color(0xFF0D0D0D),
//   altBackgroundColor: const Color(0xFF737373),
//   primaryColor: const Color(0xFF5A4C34),
//   altPrimaryColor: const Color(0xFFAD906E),
//   secondaryColor: const Color(0xFFD8D9D7),
//   altSecondaryColor: const Color(0xFF262626),
//   fontColor: const Color(0xFFF2F2F2),
//   altFontColor: const Color(0xFF262626),
//   secondaryFontColor: const Color(0xFFD8D9D7),
//   altSecondaryFontColor: const Color(0xFF737373),
// );
//
// ColorTheme lightColorTheme = ColorTheme(
//   backgroundColor: const Color(0xFFF2F2F2),
//   altBackgroundColor: const Color(0xFFF2F2F2),
//   primaryColor: const Color(0xFFAD906E),
//   altPrimaryColor: const Color(0xFF5A4C34),
//   secondaryColor: const Color(0xFF737373),
//   altSecondaryColor: const Color(0xFFA6A6A6),
//   fontColor: const Color(0xFF0D0D0D),
//   altFontColor: const Color(0xFFF2F2F2),
//   secondaryFontColor: const Color(0xFF262626),
//   altSecondaryFontColor: const Color(0xFF737373),
// );

final ColorTheme appTheme = ColorTheme(
  backgroundColor: const Color(0xFF0D0D0D),
  altBackgroundColor: const Color(0xFF737373),
  primaryColor: const Color(0xFF5A4C34),
  altPrimaryColor: const Color(0xFFAD906E),
  secondaryColor: const Color(0xFFD8D9D7),
  altSecondaryColor: const Color(0xFF262626),
  fontColor: const Color(0xFFF2F2F2),
  altFontColor: const Color(0xFF262626),
  secondaryFontColor: const Color(0xFFD8D9D7),
  altSecondaryFontColor: const Color(0xFF737373),
);

Color kWeakShadowColor = const Color(0xff000000).withOpacity(0.1);

Offset kBottomOffset = const Offset(0, 2);
Offset kTopOffset = const Offset(0, -2);

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

ButtonStyle kBrownButtonStyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll<Color>(appTheme.primaryColor),
  foregroundColor: MaterialStatePropertyAll<Color>(appTheme.fontColor),
  textStyle: const MaterialStatePropertyAll<TextStyle>(
    TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

ButtonStyle greyButtonStyle = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF737373)),
  foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF2F2F2)),
  textStyle: const MaterialStatePropertyAll<TextStyle>(
    TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
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
