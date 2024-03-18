import 'package:flutter/material.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton({
    super.key,
    this.textOnBottom = false,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final bool textOnBottom;
  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Color fontColor = const Color(0xFF595959);

    List<Widget> buttonWidgets = [
      Icon(
        icon,
        color: fontColor,
        size: 55,
      ),
      textOnBottom ? const SizedBox(height: 5) : const SizedBox(width: 15),
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textOnBottom ? 14 : 26,
          color: fontColor,
        ),
        maxLines: 2,
      ),
    ];

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
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
            return 2;
          },
        ),
      ),
      onPressed: onPressed,
      child: textOnBottom
          ? Column(
              children: buttonWidgets,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonWidgets,
            ),
    );
  }
}
