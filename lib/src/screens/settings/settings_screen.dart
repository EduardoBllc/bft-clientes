import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/color_theme.dart';
import '../../../services/controllers/settings_provider.dart';
import '../../constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = '/settigs';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;

  @override
  void initState() {
    darkMode = Provider.of<SettingsProvider>(context, listen: false).appTheme == darkColorTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme appTheme = Provider.of<SettingsProvider>(context).appTheme;

    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      appBar: defaultAppBar(context),
      body: Center(
        child: Switch(
          value: darkMode,
          inactiveTrackColor: Colors.grey.shade400,
          inactiveThumbColor: Colors.grey.shade500,
          activeTrackColor: Colors.grey.shade800,
          activeColor: Colors.grey.shade900,
          onChanged: (bool isDarkMode) {
            setState(() {
              darkMode = isDarkMode;
              Provider.of<SettingsProvider>(context, listen: false).appTheme =
                  isDarkMode ? darkColorTheme : lightColorTheme;
            });
          },
        ),
      ),
    );
  }
}
