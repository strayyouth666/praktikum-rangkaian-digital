import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/validation_error_text.dart';

import 'custom_datepicker.dart';

class CustomDatePickerFormField extends FormField<DateTime> {
  CustomDatePickerFormField(
      {Key? key,
        String? hint,
        String? label,
        bool isExpanded = false,
        bool required = false,
        bool enabled = true,
        bool isScrollup = false,
        this.controller,
        DateTime? value,
        String? Function(DateTime? value)? validator,
        void Function(DateTime value)? onDateChanged})
      : super(
      key: key,
      validator: (_) => controller != null && validator != null
          ? validator(controller.pickedDate)
          : null,
      builder: (state) {
        // if (controller != null &&
        //     controller.pickedDate != null &&
        //     // ignore: invalid_use_of_protected_member
        //     state.value == null) state..value = controller.pickedDate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDatepicker(
              isScrollup: isScrollup,
              hint: hint,
              borderColor: state.hasError ? Colors.red : null,
              label: label,
              isExpanded: isExpanded,
              required: required,
              enabled: enabled,
              type: CustomDatePickerType.date,
              onDateChanged: (val) {
                state.didChange(val);

                if (onDateChanged != null) onDateChanged(val);
              },
              controller: controller,
            ),
            ValidationErrorText(errorText: state.errorText)
          ],
        );
      });

  final CustomDatePickerController? controller;
}

class CustomTimePickerFormField extends FormField<TimeOfDay> {
  CustomTimePickerFormField(
      {Key? key,
        String? hint,
        String? label,
        bool isExpanded = false,
        bool required = false,
        bool isScrollUp = false,
        this.controller,
        String? Function(TimeOfDay? value)? validator,
        DateTime? value,
        void Function(TimeOfDay value)? onTimeChanged})
      : super(
      key: key,
      validator: (_) => controller != null && validator != null
          ? validator(controller.pickedTime)
          : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDatepicker(
              isScrollup: isScrollUp,
              hint: hint,
              borderColor: state.hasError ? Colors.red : null,
              label: label,
              isExpanded: isExpanded,
              required: required,
              type: CustomDatePickerType.time,
              onTimeChanged: (val) {
                state.didChange(val);

                if (onTimeChanged != null) onTimeChanged(val);
              },
              controller: controller,
            ),
            ValidationErrorText(errorText: state.errorText)
          ],
        );
      });

  final CustomDatePickerController? controller;
}
