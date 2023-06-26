import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'content_container.dart';
import 'file_upload_mime.dart';
// import 'package:spark_asia/components/main_layout.dart';
// import 'package:spark_asia/components/reuseable/content_container.dart';
// import 'package:spark_asia/libraries/file_upload_mime.dart';

class Helpers {
  static String parseMonth(int month, {bool short = false}) {
    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    if (short) return months[month - 1].substring(0, 3);

    return months[month - 1];
  }

  static String zeroifyOneDigitInteger(int value, {int numberOfZeroes = 1}) {
    final List<String> zeroes = List.generate(numberOfZeroes, (index) => "0");
    final stringValue = value.toString();

    return stringValue.length < numberOfZeroes + 1
        ? zeroes.sublist(stringValue.length - 1).join() + stringValue
        : stringValue;
  }

  static String parseOrdinalNumber(int number) {
    String ordinal = "th", stringedNumber = number.toString();

    if (number == 1 || (number != 11 && stringedNumber.endsWith("1"))) {
      ordinal = "st";
    } else if (number == 2 || (number != 12 && stringedNumber.endsWith("2"))) {
      ordinal = "nd";
    } else if (number == 3 || (number != 13 && stringedNumber.endsWith("3"))) {
      ordinal = "rd";
    }

    return "$stringedNumber$ordinal";
  }

  static String dateToString(DateTime? date,
      {bool userFriendly = false, bool isForParams = false}) {
    date ??= DateTime.now();

    if (userFriendly) {
      return Helpers.parseMonth(date.month) +
          " " +
          Helpers.parseOrdinalNumber(date.day) +
          " ${date.year}";
    }

    if (isForParams) {
      return '${date.year}' "-" +
          Helpers.zeroifyOneDigitInteger(date.month) +
          '-' +
          Helpers.zeroifyOneDigitInteger(date.day);
    }

    return Helpers.zeroifyOneDigitInteger(date.day) +
        "/" +
        Helpers.zeroifyOneDigitInteger(date.month) +
        "/${date.year}";
  }

  static String timeToString(TimeOfDay time) {
    return Helpers.zeroifyOneDigitInteger(time.hourOfPeriod) +
        ":" +
        Helpers.zeroifyOneDigitInteger(time.minute) +
        " " +
        time.period.name;
  }

  static DateTime timeToDateTime(TimeOfDay time) {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static double calculateDateIntervalsPercentage(
      {required DateTime begin, DateTime? end}) {
    final now = DateTime.now();
    end ??= now;
    final totalDuration = end.difference(begin).inHours;
    final elapsed = end.difference(now).inHours;

    double progress = ((totalDuration - elapsed) / totalDuration);
    progress = now.millisecondsSinceEpoch < begin.millisecondsSinceEpoch
        ? 0
        : progress;
    progress = progress.isNaN || progress.isInfinite ? 1 : progress;
    progress = progress > 1
        ? 1
        : progress < 0
        ? 0
        : progress;

    return progress;
  }

  static String roundDouble(double number, {int round = 2}) {
    final match = RegExp("(\\d+)\\..{1,$round}").stringMatch(number.toString());

    if (match == null) return "$number.0";

    return match;
  }

  static Future<BuildContext> showModal(
      {required BuildContext context,
        required Widget Function(BuildContext context) builder,
        void Function()? onExit,
        double? maxWidthAdjust,
        double? maxHeightAdjust,
        BoxConstraints? constraints,
        EdgeInsetsGeometry? contentPadding}) async {
    late BuildContext dialogContext;
    final completer = Completer();

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: Random.secure().nextInt(99999).toString(),
        pageBuilder: (context, _, __) {
          final screen = MediaQuery.of(context).size;
          dialogContext = context;

          completer.complete();

          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: ConstrainedBox(
                    constraints: constraints ??
                        BoxConstraints(
                            maxWidth: maxWidthAdjust ?? screen.width / 3,
                            maxHeight: maxHeightAdjust ?? screen.height / 2),
                    child: ContentContainer(
                        fluid: false,
                        padding: contentPadding,
                        child: Material(
                            color: Colors.transparent,
                            child: builder(context))))),
          );
        },
        transitionBuilder: (context, animation, _, child) {
          final scaleTransition =
          Tween<double>(begin: 1.1, end: 1).animate(animation);

          return Transform.scale(
              scale: scaleTransition.value,
              child: Opacity(opacity: animation.value, child: child));
        }).then((value) => onExit != null ? onExit() : null);

    await completer.future;

    return dialogContext;
  }

  // static Future<BuildContext> showLoadingDialog(BuildContext context) async {
  //   late BuildContext dialogContext;
  //   final completer = Completer();
  //
  //   showGeneralDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       transitionBuilder: (context, _, __, child) => child,
  //       pageBuilder: (context, _, __) {
  //         dialogContext = context;
  //
  //         completer.complete();
  //
  //         return Center(
  //           child: Container(
  //             padding: const EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5), color: Colors.white),
  //             child: const RotatingMinimalLogo(size: 40),
  //           ),
  //         );
  //       });
  //
  //   await completer.future;
  //
  //   return dialogContext;
  // }

  static void debugPrint(Object? e) {
    String? message;

    if (e is List) {
      message = e.join("\t");
    } else if (e is String) {
      message = e;
    }

    if (kDebugMode) print(message);
  }

  static String makePercentage(double value,
      {bool addLastTwoDecimals = false}) {
    var valueString = (value * 100).toString();
    final digits = valueString.split(".");

    if (addLastTwoDecimals) {
      if (digits.length > 1) {
        valueString =
        "${digits.first}.${digits.last.length > 2 ? digits.last.substring(0, 2) : digits.last}";
      } else {
        valueString = "${digits.first}.00";
      }
    } else {
      valueString = (value * 100).round().toString();
    }

    return "$valueString%";
  }

  static FileUploadMime getFileUploadMime({required String extension}) {
    String mimeType = "text", mimeSubType = extension;

    switch (extension) {
      case "bmp":
      case "jpeg":
      case "png":
      case "gif":
      case "webp":
        mimeType = "image";
        break;
      case "jpg":
        mimeType = "image";
        mimeSubType = "jpeg";
        break;
      case "docx":
        mimeType = "application";
        mimeSubType =
        "vnd.openxmlformats-officedocument.wordprocessingml.document";
        break;
      case "doc":
        mimeType = "application";
        mimeSubType = "msword";
        break;
      case "pdf":
        mimeType = "application";
        mimeSubType = "pdf";
        break;
      case "ppt":
        mimeType = "application";
        mimeSubType = "vnd.ms-powerpoint";
        break;
      case "pptx":
        mimeType = "application";
        mimeSubType =
        "vnd.openxmlformats-officedocument.presentationml.presentation";
        break;
      case "xls":
        mimeType = "application";
        mimeSubType = "vnd.ms-excel";
        break;
      case "xlsx":
        mimeType = "application";
        mimeSubType = "vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        break;
      default:
    }

    return FileUploadMime(mimeType: mimeType, mimeSubType: mimeSubType);
  }
}
