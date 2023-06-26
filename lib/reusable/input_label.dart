import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';


class InputLabel extends StatelessWidget {
  final String label;
  final bool required;
  final Widget child;
  final String? hint;

  const InputLabel(
      {Key? key,
        this.hint,
        required this.label,
        this.required = false,
        required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            style: const TextStyle(color: ProjectColors.defaultBlack),
            children: [
              TextSpan(text: label),
              TextSpan(
                  text: required ? " *" : null,
                  style: const TextStyle(color: Colors.red))
            ])),
        const SizedBox(height: 5),
        child
      ],
    );
  }
}

