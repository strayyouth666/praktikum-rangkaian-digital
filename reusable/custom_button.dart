import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

import 'clickable_ripple.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? child;
  final String? value;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final bool enabled, isExpanded;
  final Brightness? brightness;

  const CustomButton(
      {Key? key,
        this.onTap,
        this.child,
        this.value,
        this.color,
        this.textStyle,
        this.padding,
        this.borderRadius,
        this.enabled = true,
        this.isExpanded = false,
        this.border,
        this.brightness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? ProjectColors.blue;

    return DecoratedBox(
      decoration: BoxDecoration(
          border: border,
          color: enabled ? buttonColor : buttonColor.withAlpha(100),
          borderRadius: borderRadius ?? BorderRadius.circular(5)),
      child: ClickableRipple(
        brightness: brightness ?? Brightness.light,
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        child: Container(
          width: isExpanded ? double.infinity : null,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: textStyle ?? const TextStyle(color: Colors.white),
            child: child ??
                Text(
                  value ?? "Button",
                ),
          ),
        ),
      ),
    );
  }
}
