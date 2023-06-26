import 'package:flutter/material.dart';

class LoadingPlaceholder extends StatefulWidget {
  const LoadingPlaceholder({Key? key, this.width, this.height})
      : super(key: key);

  final double? width, height;

  @override
  _LoadingPlaceholderState createState() => _LoadingPlaceholderState();
}

class _LoadingPlaceholderState extends State<LoadingPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final beginAnimation =
    Tween<double>(begin: -4, end: 3).animate(_controller);
    final endAnimation = Tween<double>(begin: -1, end: 6).animate(_controller);

    return Container(
      width: widget.width ?? 300,
      height: widget.height ?? 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment(beginAnimation.value, 0),
            end: Alignment(endAnimation.value, 0),
            colors: const [
              Color(0xffdddddd),
              Color(0xfff5f5f5),
              Color(0xffdddddd)
            ],
          )),
    );
  }
}

