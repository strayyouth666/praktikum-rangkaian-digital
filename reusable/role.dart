// import 'package:flutter/material.dart';
//
// import 'api.dart';
//
// enum Role { member, coach, admin, advisor, all }
//
// class RoleView extends StatelessWidget {
//   const RoleView(
//       {Key? key,
//         this.roles,
//         required this.child,
//         this.type = RoleViewType.include,
//         this.role})
//       : super(key: key);
//
//   final List<Role>? roles;
//   final Role? role;
//   final RoleViewType type;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     final _role = role ?? Api.of(context).role;
//
//     if (roles == null ||
//         (roles!.contains(_role) && type == RoleViewType.include) ||
//         (!roles!.contains(_role) && type == RoleViewType.exclude)) {
//       return child;
//     }
//
//     return const SizedBox();
//   }
// }
//
// enum RoleViewType { include, exclude }
