import 'package:flutter/material.dart';

class StandardModal extends StatelessWidget {
  const StandardModal({
    super.key,
    required this.body,
    this.maxHeight,
    this.topRightButton,
  });

  final Widget body;
  final Widget? topRightButton;
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
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
            if (topRightButton != null)
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: topRightButton,
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
