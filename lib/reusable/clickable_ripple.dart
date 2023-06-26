import 'package:flutter/material.dart';

class ClickableRipple extends StatelessWidget {
  const ClickableRipple(
      {Key? key,
        this.onTap,
        required this.child,
        this.borderRadius,
        this.brightness = Brightness.dark})
      : super(key: key);

  final void Function()? onTap;
  final Widget child;
  final BorderRadius? borderRadius;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final isDark = brightness == Brightness.dark;

    return Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: isDark
              ? Colors.black.withOpacity(.1)
              : Colors.white.withOpacity(.2),
          splashColor: isDark
              ? Colors.black.withOpacity(.05)
              : Colors.white.withOpacity(.2),
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ));
  }
}

