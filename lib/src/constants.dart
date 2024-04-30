import 'package:bft_clientes/models/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

ButtonStyle shapedButtonStyle = ButtonStyle(
  overlayColor: MaterialStatePropertyAll<Color>(Colors.black.withOpacity(0.1)),
  elevation: const MaterialStatePropertyAll<double>(0),
  shape: MaterialStatePropertyAll<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

ColorTheme darkColorTheme = ColorTheme(
  isDarkTheme: true,
  backgroundColor: const Color(0xFF0D0D0D),
  altBackgroundColor: const Color(0xFF262626),
  primaryColor: const Color(0xFF5A4C34),
  altPrimaryColor: const Color(0xFFAD906E),
  secondaryColor: const Color(0xFFD8D9D7),
  altSecondaryColor: const Color(0xFF737373),
  fontColor: const Color(0xFFF2F2F2),
  altFontColor: const Color(0xFF262626),
  secondaryFontColor: const Color(0xFFD8D9D7),
  altSecondaryFontColor: const Color(0xFF737373),
  primaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF5A4C34)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF2F2F2)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  altPrimaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffad906e)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  secondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF737373)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF262626)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  altSecondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFD8D9D7)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF262626)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  mainScreenPrimaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF262626)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFD8D9D7)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  mainScreenSecondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF737373)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFD8D9D7)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  listBackgroundColor: const Color(0xFF262626),
  modalBackgroundColor: const Color(0xFF262626),
);

ColorTheme lightColorTheme = ColorTheme(
  isDarkTheme: false,
  backgroundColor: const Color(0xFFF1ECE9),
  altBackgroundColor: const Color(0xFFE0D8CF),
  primaryColor: const Color(0xffad906e),
  altPrimaryColor: const Color(0xff886a4a),
  secondaryColor: const Color(0xFFEEE7E2),
  altSecondaryColor: const Color(0xFFA6A6A6),
  fontColor: const Color(0xFF262626),
  altFontColor: const Color(0xFFF2F2F2),
  secondaryFontColor: const Color(0xFF262626),
  altSecondaryFontColor: const Color(0xFF737373),
  primaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xffad906e)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  altPrimaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF5A4C34)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFF2F2F2)),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  secondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    foregroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade700),
  ),
  altSecondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFF737373)),
    foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
  ),
  mainScreenPrimaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Color(0xFFE0D8CF)),
    foregroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade700),
    textStyle: const MaterialStatePropertyAll<TextStyle>(
      TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  mainScreenSecondaryButtonStyle: shapedButtonStyle.copyWith(
    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
    foregroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade700),
  ),
  listBackgroundColor: const Color(0xFFEEE7E2),
  modalBackgroundColor: Colors.white,
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

AppBar defaultAppBar(context, {List<Widget>? actions, void Function()? onReturnPressed, bool hasReturnButton = true}) {
  return AppBar(
    actions: actions,
    leading: hasReturnButton
        ? TextButton(
            onPressed: () {
              if (onReturnPressed != null) {
                onReturnPressed();
              } else {
                Navigator.pop(context);
              }
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          )
        : const SizedBox(),
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
}

Scaffold underDevelopmentScreen(BuildContext context) {
  return Scaffold(
    appBar: defaultAppBar(context),
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
}

RegExp kNumbersOnlyRegex = RegExp(r'\d+');

MaskTextInputFormatter kCellphoneMask =
    MaskTextInputFormatter(mask: '(##)#####-####', filter: {'#': kNumbersOnlyRegex});
