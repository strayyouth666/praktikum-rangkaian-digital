import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  final Widget child;
  final bool isAlwaysShown;
  final Axis? scrollDirection;

  const ScrollWidget(
      {Key? key,
        required this.child,
        this.isAlwaysShown = true,
        this.scrollDirection,
        this.controller})
      : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final _scrollController = controller ?? ScrollController();

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: isAlwaysShown,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: scrollDirection ?? Axis.vertical,
        child: child,
      ),
    );
  }
}
