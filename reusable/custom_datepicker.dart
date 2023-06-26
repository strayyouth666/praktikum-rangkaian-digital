import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

import 'clickable_ripple.dart';
import 'helpers.dart';
import 'input_label.dart';

class CustomDatepicker extends StatefulWidget {
  final String? hint, label;
  final bool isExpanded, required, enabled;
  final CustomDatePickerController? controller;
  final CustomDatePickerType type;
  final DateTime? value;
  final void Function(DateTime value)? onDateChanged;
  final void Function(String value)? onDateChangedFilter;
  final void Function(TimeOfDay value)? onTimeChanged;
  final Color? borderColor;
  final bool isForFilter;
  final bool isIconCalendar;
  final bool isScrollup;

  const CustomDatepicker(
      {Key? key,
        this.hint,
        this.label,
        this.isScrollup = false,
        this.isExpanded = false,
        this.controller,
        this.type = CustomDatePickerType.date,
        this.required = false,
        this.value,
        this.onDateChanged,
        this.onDateChangedFilter,
        this.onTimeChanged,
        this.borderColor,
        this.enabled = true,
        this.isForFilter = false,
        this.isIconCalendar = false})
      : super(key: key);

  @override
  _CustomDatepickerState createState() => _CustomDatepickerState();
}

class _CustomDatepickerState extends State<CustomDatepicker> {
  String? hint;
  String? value;

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    widget.controller?._state = this;

    if (hint == null && widget.hint != null) hint = widget.hint;
    if (value == null) {
      if (widget.value != null) {
        if (widget.type == CustomDatePickerType.date) {
          value = widget.value!.toString().split(" ")[0];
          widget.controller?.pickedDate = widget.value;
        } else {
          value = TimeOfDay.fromDateTime(widget.value!).toString();
          widget.controller?.pickedTime = TimeOfDay.fromDateTime(widget.value!);
        }
      }

      if (widget.controller != null) {
        final controller = widget.controller!;

        if (widget.type == CustomDatePickerType.date &&
            controller.pickedDate != null) {
          value = controller.pickedDate.toString().split(" ")[0];
        } else if (widget.type == CustomDatePickerType.time &&
            controller.pickedTime != null) {
          value = Helpers.timeToString(controller.pickedTime!);
        }
      }
    }

    final datePicker = ClickableRipple(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.enabled
          ? () {
        // if (widget.isScrollup) {
        //   Api.of(context).scrollTo(context,
        //       position: LayoutBodyScrollController.of(context)
        //           .position
        //           .minScrollExtent);
        // }
        if (widget.type == CustomDatePickerType.date) {
          _selectDate();
        } else if (widget.type == CustomDatePickerType.time) {
          _selectTime();
        }
      }
          : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: widget.isExpanded ? double.infinity : null,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.5, color: widget.borderColor ?? const Color(0xffdddddd)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.isExpanded
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Text(
              value ?? hint ?? "Select ${widget.type.name}",
              style: TextStyle(
                fontSize: 16,
                color: value == null ? Colors.grey : ProjectColors.defaultBlack,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              widget.isIconCalendar == false
                  ? Icons.arrow_drop_down
                  : Icons.calendar_today,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );

    if (widget.label != null) {
      return InputLabel(
          label: widget.label!, child: datePicker, required: widget.required);
    }

    return datePicker;
  }

  _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: widget.controller?.pickedTime ??
            const TimeOfDay(hour: 0, minute: 0));

    if (picked != null) {
      widget.controller?.pickedTime = picked;

      setState(() {
        value = Helpers.timeToString(picked);
      });

      if (widget.onTimeChanged != null) widget.onTimeChanged!(picked);
    }
  }

  _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.controller?.pickedDate ?? DateTime.now(),
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2099));
    if (picked != null) {
      widget.controller?.pickedDate = picked;

      setState(() {
        value = picked.toString().split(" ")[0];
      });

      if (widget.onDateChanged != null) widget.onDateChanged!(picked);
      if (widget.onDateChangedFilter != null) {
        widget.onDateChangedFilter!(value!);
      }
    }
    if (picked == null && widget.isForFilter) {
      setState(() {
        value = null;
      });
      if (widget.onDateChangedFilter != null) {
        widget.onDateChangedFilter!('');
      }
    }
  }
}

enum CustomDatePickerType { date, time }

class CustomDatePickerController {
  late _CustomDatepickerState _state;
  TimeOfDay? pickedTime;
  DateTime? pickedDate;

  void _update() {
    try {
      _state.value = null;
      _state.update();
      // ignore: empty_catches
    } catch (e) {}
  }

  set date(DateTime? date) {
    pickedDate = date;
    _update();
  }

  set time(TimeOfDay time) {
    pickedTime = time;
    _update();
  }

  set initialDate(DateTime? date) {
    pickedDate ??= date;
  }

  set initialTime(TimeOfDay? time) {
    pickedTime ??= time;
  }

  @override
  String toString() {
    if (pickedDate != null && pickedTime != null) {
      return "${pickedDate!.year}-${Helpers.zeroifyOneDigitInteger(pickedDate!.month)}-${Helpers.zeroifyOneDigitInteger(pickedDate!.day)} ${Helpers.zeroifyOneDigitInteger(pickedTime!.hour)}:${Helpers.zeroifyOneDigitInteger(pickedTime!.minute)}:00";
    }

    if (pickedDate != null && pickedTime == null) {
      return "${pickedDate!.year}-${Helpers.zeroifyOneDigitInteger(pickedDate!.month)}-${Helpers.zeroifyOneDigitInteger(pickedDate!.day)} ${Helpers.zeroifyOneDigitInteger(pickedDate!.hour)}:${Helpers.zeroifyOneDigitInteger(pickedDate!.minute)}:00";
    }

    return "0000-00-00 00:00:00";
  }
}
