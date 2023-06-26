import 'package:flutter/material.dart';

class PopupDialog extends StatefulWidget {
  const PopupDialog(
      {Key? key,
        this.shown = false,
        this.width,
        required this.child,
        this.padding,
        this.duration = const Duration(milliseconds: 150)})
      : super(key: key);

  final bool shown;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Duration duration;

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaleAnimation = Tween<double>(begin: .5, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.shown) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    if (!widget.shown && _controller.value <= 0) return const SizedBox();

    return Opacity(
      opacity: _controller.value,
      child: Transform.scale(
        scale: _scaleAnimation.value,
        alignment: const Alignment(1, -1),
        child: Container(
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            width: widget.width,
            padding: widget.padding,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 8.0,
                  offset: const Offset(0, 3),
                  color: Colors.black.withOpacity(.2))
            ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: widget.child),
      ),
    );
  }
}

