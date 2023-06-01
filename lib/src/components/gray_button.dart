import 'package:flutter/cupertino.dart';
import '../constants/button_color.dart';
import '../constants/button_size.dart';

class GrayButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  const GrayButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ButtonSize.Short,
      height: ButtonSize.Short,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(100),
        padding: const EdgeInsets.all(16.0),
        color: ButtonColor.glay,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
