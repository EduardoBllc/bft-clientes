import 'package:flutter/material.dart';

class MainScreenButton extends StatelessWidget {
  const MainScreenButton({
    super.key,
    this.reverted = false,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final bool reverted;
  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Color fontColor = const Color(0xFF595959);

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
            return 3;
          },
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: reverted
              ? [
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: fontColor,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Icon(
                    icon,
                    color: fontColor,
                    size: 60,
                  ),
                ]
              : [
                  Icon(
                    icon,
                    color: fontColor,
                    size: 60,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: fontColor,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
