// import 'dart:math';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:spark_asia/components/layout_body.dart';
// import 'package:spark_asia/components/screens/assessment/eepa.dart';
// import 'package:spark_asia/components/screens/public/public_eepa.dart';
// import 'package:spark_asia/components/single_use/sidebar.dart';
// import 'package:spark_asia/libraries/abstracts/assessment_type.dart';
// import 'package:spark_asia/libraries/abstracts/navigation_popup_dialog.dart';
// import 'package:spark_asia/system/api.dart';
// import 'package:spark_asia/system/helpers.dart';
// import 'package:spark_asia/system/models/session.dart';
//
// import 'helpers.dart';
//
// class MainLayout extends StatefulWidget {
//   const MainLayout({Key? key, required this.initialScreen}) : super(key: key);
//
//   final Widget initialScreen;
//
//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }
//
// class _MainLayoutState extends State<MainLayout> {
//   bool loginPressed = false || !kDebugMode;
//   bool rememberMe = false;
//
//   toggleRememberMe(bool? val) {
//     setState(() {
//       rememberMe = val ?? false;
//     });
//   }
//
//   goToDashboard() {
//     setState(() {
//       loginPressed = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _mediaQuery = MediaQuery.of(context).size,
//         _sidebarWidth = SideBar.getWidth(context);
//     final api = Api.of(context);
//     final children = <Widget>[];
//     children.add(StreamBuilder<double>(
//         initialData: 0,
//         stream: api.sidebarVisibilityAnimationState.stream,
//         builder: (context, snapshot) {
//           final width = _sidebarWidth - snapshot.data!;
//
//           return Positioned(
//             left: width,
//             top: 0.0,
//             right: 0.0,
//             bottom: 0.0,
//             child: SizedBox(
//               width: _mediaQuery.width - width,
//               height: _mediaQuery.height,
//               child: LayoutBody(initialScreen: widget.initialScreen),
//             ),
//           );
//         }));
//
//     children.add(const SideBar());
//
//     return FutureBuilder<Api>(
//         future: api.init(),
//         builder: (context, snapshot) {
//           Helpers.debugPrint("Initialization error: ${snapshot.error}");
//
//           if (!snapshot.hasData) {
//             return const Center(child: RotatingMinimalLogo());
//           }
//
//           if (api.router.initialRoute != null &&
//               api.router.initialRoute!.contains("public")) {
//             return Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/img/bg-login.jpg"),
//                           fit: BoxFit.cover)),
//                 ),
//                 Center(
//                   child: Builder(builder: (context) {
//                     final initialRoute = api.router.initialRoute!;
//
//                     api.credential
//                       ..accessToken = ""
//                       ..refreshToken = "";
//
//                     if (initialRoute
//                         .contains(RegExp("session/([a-z0-9-]{36})/eepa"))) {
//                       return PublicEEPA();
//                     }
//
//                     return const SizedBox();
//                   }),
//                 )
//               ],
//             );
//           }
//
//           if (!api.credential.authorized) {
//             Future.microtask(() {
//               Navigator.of(context).popAndPushNamed("login");
//             });
//           }
//
//           return GestureDetector(
//             onTap: () {
//               // Clicking outside
//               api.navigationPopupDialogControllerState
//                   .showDialog(NavigationPopupDialogs.none);
//             },
//             child: SizedBox(
//               width: double.infinity,
//               child: Stack(children: children),
//             ),
//           );
//         });
//   }
// }
//
// class RotatingMinimalLogo extends StatefulWidget {
//   const RotatingMinimalLogo({Key? key, this.size = 80}) : super(key: key);
//
//   final double size;
//
//   @override
//   _RotatingMinimalLogoState createState() => _RotatingMinimalLogoState();
// }
//
// class _RotatingMinimalLogoState extends State<RotatingMinimalLogo>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//     AnimationController(vsync: this, duration: const Duration(seconds: 1))
//       ..addListener(() {
//         setState(() {});
//       })
//       ..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final _animation =
//     CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//
//     return Transform.rotate(
//         angle: (2 * pi) * _animation.value,
//         child:
//         Image.asset("assets/img/we_spark_minimal.png", width: widget.size));
//   }
// }
//
