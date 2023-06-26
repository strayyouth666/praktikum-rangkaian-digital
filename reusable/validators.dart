class Validators {
  final String value;

  Validators({required this.value});

  static String emptyValueError = "This field cannot be empty";
  static String invalidEmailError = "The email is invalid";
  static String lessThanRequiredError =
      "The text you entered is less than required";
  static String invalidPassword = "The password you entered is invalid";

  bool validateEmail() => value.contains(RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'));
  bool validatePassword() => value.contains(RegExp(
      r"(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$&*])[a-zA-Z\d\W]{8,}"));
  String? emailValidator() =>
      !validateEmail() ? Validators.invalidEmailError : null;

  String? nonEmptyValueValidator() =>
      value.isEmpty ? Validators.emptyValueError : null;
}

