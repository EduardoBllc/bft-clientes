import 'package:bft_clientes/src/constants.dart';
import 'package:flutter/material.dart';

class StandardModal extends StatelessWidget {
  const StandardModal({
    super.key,
    required this.body,
    this.maxHeight,
    this.topRightButtons,
  });

  final Widget body;
  final List<Widget>? topRightButtons;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: 10,
        maxHeight: maxHeight ?? MediaQuery.sizeOf(context).height * 0.4,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: appTheme.altSecondaryColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(18),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 5,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            if (topRightButtons != null)
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: topRightButtons!,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
