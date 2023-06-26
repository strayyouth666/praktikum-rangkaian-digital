import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

import 'custom_button.dart';

Widget paginationButton(
    void Function() onTap, String value, bool active, bool disabled) {
  return CustomButton(
      value: value,
      onTap: onTap,
      enabled: !disabled,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      textStyle:
      TextStyle(color: active ? Colors.white : ProjectColors.defaultBlack),
      color: active ? ProjectColors.red : Colors.transparent);
}

