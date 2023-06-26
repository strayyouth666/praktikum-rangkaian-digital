import 'package:flutter/material.dart';

class AdaptiveGridView extends StatefulWidget {
  const AdaptiveGridView(
      {Key? key,
        this.crossAxisCount,
        this.crossAxisSpacing,
        this.mainAxisSpacing,
        required this.children,
        this.intrinsictHeight = true})
      : super(key: key);

  final int? crossAxisCount;
  final double? crossAxisSpacing, mainAxisSpacing;
  final List<Widget> children;
  final bool intrinsictHeight;

  @override
  State<AdaptiveGridView> createState() => _AdaptiveGridViewState();
}

class _AdaptiveGridViewState extends State<AdaptiveGridView> {
  final List<GlobalKey> keys = [];
  double? maxHeight;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (maxHeight == null) {
        for (final key in keys) {
          if ((maxHeight ?? 0) < key.currentContext!.size!.height) {
            maxHeight = key.currentContext!.size!.height;
          }
        }

        setState(() {
          maxHeight = maxHeight! + 10;
        });
      }
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    final _crossAxisCount = widget.crossAxisCount ?? 1;
    final _crossAxisSpacing = widget.crossAxisSpacing ?? 0;

    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        spacing: _crossAxisSpacing,
        runSpacing: widget.mainAxisSpacing ?? 0,
        children: List.generate(widget.children.length, (index) {
          final child = widget.children[index];

          if (keys.length < index + 1) keys.add(GlobalKey());

          return SizedBox(
            width: (constraints.maxWidth / _crossAxisCount) -
                (_crossAxisSpacing * 2),
            child: LayoutBuilder(builder: (context, constraints2) {
              return FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  key: keys[index],
                  height: widget.intrinsictHeight ? maxHeight : null,
                  width: constraints2.maxWidth,
                  child: Builder(builder: (context) {
                    return child;
                  }),
                ),
              );
            }),
          );
        }).toList(),
      );
    });
  }
}
