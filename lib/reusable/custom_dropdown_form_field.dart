import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/validation_error_text.dart';

import 'custom_dropdown.dart';

class CustomDropdownFormField<T> extends FormField<T> {
  CustomDropdownFormField(
      {Key? key,
        FormFieldValidator<T>? validator,
        required List<DropdownMenuItem<T>> items,
        void Function(T? value)? onChanged,
        void Function(List<T> value)? onMultipleValuesChanged,
        void Function()? dropDownOnTap,
        String? hint,
        bool isExpanded = false,
        bool hintAtTheTop = false,
        bool searcheable = false,
        bool canRetractValue = false,
        this.controller,
        bool allowMultipleValues = false,
        bool required = false,
        bool enabled = false})
      : super(
      key: key,
      validator: validator,
      initialValue: controller?.value,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropdown<T>(
                dropDownOnTap: dropDownOnTap,
                allowMultipleValues: allowMultipleValues,
                borderColor: state.hasError ? Colors.red : null,
                items: items,
                canRetractValue: canRetractValue,
                onMultipleValuesChanged: onMultipleValuesChanged,
                onChanged: (val) {
                  state.didChange(val);

                  if (onChanged != null) onChanged(val);
                },
                hint: hint,
                isExpanded: isExpanded,
                hintAtTheTop: hintAtTheTop,
                controller: controller,
                searcheable: searcheable,
                enabled: enabled,
                required: required),
            ValidationErrorText(errorText: state.errorText)
          ],
        );
      });

  final CustomDropdownController<T>? controller;
}
