import 'package:flutter/material.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key, this.icon, required this.menuList}) : super(key: key);
  final Widget? icon;
  final List<PopupMenuEntry> menuList;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: ((context) => menuList),
        icon: icon,
    );
  }
}
