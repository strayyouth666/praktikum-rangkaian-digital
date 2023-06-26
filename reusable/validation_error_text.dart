import 'package:flutter/material.dart';

class ValidationErrorText extends StatelessWidget {
  const ValidationErrorText({
    Key? key,
    this.errorText,
  }) : super(key: key);

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    if (errorText == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12)),
        ),
      ],
    );
  }
}

