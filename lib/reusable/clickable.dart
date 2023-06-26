import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  const Clickable(
      {Key? key,
        this.onTap,
        this.onDoubleTap,
        required this.child,
        this.cursor})
      : super(key: key);

  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final Widget child;
  final MouseCursor? cursor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: cursor ?? SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          child: child,
        ));
  }
}
