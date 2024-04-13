import 'package:flutter/material.dart';

class ColorTheme {
  final Color backgroundColor;
  final Color altBackgroundColor;
  final Color primaryColor;
  final Color altPrimaryColor;
  final Color secondaryColor;
  final Color altSecondaryColor;
  final Color fontColor;
  final Color altFontColor;
  final Color secondaryFontColor;
  final Color altSecondaryFontColor;

  final Color listBackgroundColor;
  final Color modalBackgroundColor;

  final ButtonStyle primaryButtonStyle;
  final ButtonStyle secondaryButtonStyle;
  final ButtonStyle mainScreenPrimaryButtonStyle;
  final ButtonStyle mainScreenSecondaryButtonStyle;

  ColorTheme({
    required this.backgroundColor,
    required this.altBackgroundColor,
    required this.primaryColor,
    required this.altPrimaryColor,
    required this.secondaryColor,
    required this.altSecondaryColor,
    required this.fontColor,
    required this.altFontColor,
    required this.secondaryFontColor,
    required this.altSecondaryFontColor,
    required this.primaryButtonStyle,
    required this.secondaryButtonStyle,
    required this.mainScreenPrimaryButtonStyle,
    required this.mainScreenSecondaryButtonStyle,
    required this.listBackgroundColor,
    required this.modalBackgroundColor,
  });
}
