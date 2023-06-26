import 'package:flutter/cupertino.dart';

class TextEditingControllerGenerator<T> {
  final Map<T, TextEditingController> _controllers = {};

  TextEditingController controller(T field) => _controllers[field]!;

  void setInitialValue({required T field, String? value}) {
    if (value != null && controller(field).value.text.isEmpty) {
      controller(field).value = TextEditingValue(text: value);
    }
  }

  void setValue({required T field, String? value}) {
    if (value != null) {
      controller(field).value = TextEditingValue(text: value);
    }
  }

  void generate(List<T> fields) {
    for (T field in fields) {
      _controllers[field] = TextEditingController();
    }
  }

  String getValue(T field) {
    return controller(field).value.text;
  }

  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
  }
}

