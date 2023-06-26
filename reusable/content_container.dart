import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

class ContentContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Clip? clipBeahvior;
  final bool fluid;
  final double? width, height;
  final BoxConstraints? constraints;

  const ContentContainer(
      {Key? key,
        this.child,
        this.padding,
        this.clipBeahvior,
        this.fluid = true,
        this.width,
        this.height,
        this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clipBeahvior ?? Clip.none,
      width: width ?? (fluid ? double.infinity : null),
      height: height,
      constraints: constraints,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: ProjectColors.defaultBlack.withOpacity(.3),
                offset: const Offset(0, 2),
                blurRadius: 10.0)
          ]),
      child: child ?? const SizedBox(),
    );
  }
}
