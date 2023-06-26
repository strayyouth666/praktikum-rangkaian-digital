import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'clickable_ripple.dart';
import 'input_label.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {Key? key,
      this.hint,
      this.controller,
      this.validator,
      this.maxLines,
      this.borderRadius,
      this.label,
      this.obscureText = false,
      this.showSeekButton = false,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.isHintAboveForm = false,
      this.onChanged,
      this.onFieldSubmitted,
      this.enabled = true,
      this.focusNode,
      this.required = false,
      this.prefix,
      this.inputFormatters,
      this.lineExpand = false,
      this.expand = false,
      this.initialValue})
      : super(key: key);

  final String? hint, label, initialValue;
  final bool isHintAboveForm;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String? val)? validator;
  final int? maxLines;
  final BorderRadius? borderRadius;
  final bool expand, lineExpand;
  final bool obscureText, showSeekButton, enabled, required;
  final Widget? prefixIcon, suffixIcon, prefix;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool? obscureText;
  String? value;

  onChanged(String val) {
    setState(() {
      value = val;
    });

    if (widget.onChanged != null) widget.onChanged!(val);
  }

  onFieldSubmitted(String val) {
    setState(() {
      value = val;
    });

    if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(val);
  }

  toggleObscureText() {
    setState(() {
      obscureText = !obscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {
    obscureText ??= widget.obscureText;

    Widget? suffixIcon = widget.suffixIcon;

    if (widget.obscureText && widget.showSeekButton) {
      suffixIcon = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClickableRipple(
              child: Icon(
                  obscureText! ? Icons.visibility : Icons.visibility_off,
                  color: ProjectColors.defaultBlack),
              onTap: toggleObscureText));
    }

    final input = TextFormField(
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: (val) {
        for (final codeUnit in val!.codeUnits) {
          if (((codeUnit < 32 || codeUnit >= 127) && codeUnit < 19968) ||
              codeUnit > 40869) {
            return "Use of unsupported character(s) detected.";
          }
        }

        if (widget.validator != null) return widget.validator!(val);

        return null;
      },
      maxLines: widget.obscureText
          ? 1
          : widget.lineExpand == true
              ? null
              : widget.maxLines ?? 1,
      minLines: null,
      expands: widget.expand,
      obscureText: obscureText!,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: widget.inputFormatters,
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
          isDense: true,
          errorMaxLines: 3,
          suffixIcon: suffixIcon,
          prefix: widget.prefix,
          prefixIcon: widget.prefixIcon,
          hintText: widget.isHintAboveForm == false ? widget.hint ?? '' : "",
          fillColor: widget.enabled ? Colors.white : const Color(0xfff5f5f5),
          filled: true,
          isCollapsed: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          errorBorder: inputBorder(ProjectColors.red),
          focusedErrorBorder: inputBorder(ProjectColors.red),
          disabledBorder: inputBorder(const Color(0xffdddddd)),
          enabledBorder: inputBorder(const Color(0xffdddddd)),
          focusedBorder: inputBorder(ProjectColors.blue)),
    );

    if (widget.label != null) {
      return InputLabel(
          label: widget.label!,
          required: widget.required,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isHintAboveForm)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.hint!,
                      style: const TextStyle(
                          color: ProjectColors.defaultBlack, fontSize: 10),
                    ),
                    const SizedBox(height: 5)
                  ],
                ),
              input,
            ],
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isHintAboveForm)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.hint!,
                style: const TextStyle(
                    color: ProjectColors.defaultBlack, fontSize: 12),
              ),
              const SizedBox()
            ],
          ),
        input,
      ],
    );
  }

  OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1.5));
}
