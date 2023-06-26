import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/popup_dialog.dart';
import 'package:smartcare_web/reusable/scroll_widget.dart';

import 'clickable_ripple.dart';

class NotificationPopup extends StatelessWidget {
  const NotificationPopup({
    Key? key,
    this.notificationPopupShown = false,
  }) : super(key: key);

  final bool notificationPopupShown;

  @override
  Widget build(BuildContext context) {
    return PopupDialog(
        width: 400,
        child: ScrollWidget(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("NOTIFICATIONS",
                            style: TextStyle(
                                fontSize: 17, color: Color(0xff777777))),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Text("5 new",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)))
                      ]),
                ),
                const LineSeparator(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
                const NotificationList(),
              ]),
        ),
        shown: notificationPopupShown);
  }
}

class LineSeparator extends StatelessWidget {
  const LineSeparator({
    Key? key,
    this.axis = Axis.horizontal,
    this.color,
  }) : super(key: key);

  final Axis axis;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 1,
        color: color ?? const Color(0xffeeeeee));
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableRipple(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "A new order has been placed!",
              style: TextStyle(color: Color(0xff777777)),
            ),
            SizedBox(height: 2),
            Text("2 hours ago",
                style: TextStyle(
                  color: Color(0xffcccccc),
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }
}

