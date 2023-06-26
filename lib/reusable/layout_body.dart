// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:smartcare_web/reusable/project_colors.dart';
// import 'package:smartcare_web/reusable/scroll_widget.dart';
// import 'package:smartcare_web/reusable/user_popup.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'api.dart';
// import 'clickable.dart';
// import 'footer.dart';
// import 'navigation_popup_dialog.dart';
// import 'notification_popup.dart';
//
// class LayoutBody extends StatefulWidget {
//   const LayoutBody({Key? key, required this.initialScreen}) : super(key: key);
//
//   final Widget initialScreen;
//
//   @override
//   _LayoutBodyState createState() => _LayoutBodyState();
// }
//
// class _LayoutBodyState extends State<LayoutBody> {
//   @override
//   Widget build(BuildContext context) {
//     final api = Api.of(context);
//     Widget initialScreen = widget.initialScreen;
//
//     // if (api.router.initialRoute != null) {
//     //
//     //   api.router.push("initial_url", api.router.initialRoute!);
//     // }
//
//     api.screenControllerState.previousScreen ??= initialScreen;
//
//     return LayoutBodyScrollController(
//       child: Builder(builder: (context) {
//         return ScrollWidget(
//           controller: LayoutBodyScrollController.of(context),
//           child: Stack(
//             children: [
//               Container(
//                   height: 200,
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [ProjectColors.purple, ProjectColors.orange],
//                         transform: GradientRotation(pi / 4)),
//                     boxShadow: [],
//                   )),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
//                   child: NavigationBody(),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 10),
//                     child: StreamBuilder<Widget>(
//                         stream: api.screenControllerState.stream,
//                         builder: (context, AsyncSnapshot<Widget> data) {
//                           if (data.hasData) {
//                             api.scrollTo(context);
//                           }
//
//                           return data.data ?? initialScreen;
//                         })),
//                 const SizedBox(height: 10),
//                 const Align(alignment: Alignment.bottomCenter, child: Footer())
//               ]),
//               ConstrainedBox(
//                 constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height),
//                 child: StreamBuilder(
//                     stream: api.navigationPopupDialogControllerState.stream,
//                     initialData: NavigationPopupDialogs.none,
//                     builder: (context,
//                         AsyncSnapshot<NavigationPopupDialogs> snapshot) {
//                       final data = snapshot.data;
//                       final notificationPopupShown =
//                           data == NavigationPopupDialogs.notification;
//                       final userPopupShown =
//                           data == NavigationPopupDialogs.user;
//                       const top = 50.0;
//
//                       return Stack(
//                         children: [
//                           Positioned(
//                               right: 70,
//                               top: top,
//                               child: NotificationPopup(
//                                   notificationPopupShown:
//                                   notificationPopupShown)),
//                           Positioned(
//                               right: 20,
//                               top: top,
//                               child: UserPopup(userPopupShown: userPopupShown)),
//                         ],
//                       );
//                     }),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class LayoutBodyScrollController extends InheritedWidget {
//   LayoutBodyScrollController({Key? key, required Widget child})
//       : super(key: key, child: child);
//
//   final controller = ScrollController();
//
//   static ScrollController of(BuildContext context) => context
//       .dependOnInheritedWidgetOfExactType<LayoutBodyScrollController>()!
//       .controller;
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
// }
//
// class NavigationBody extends StatelessWidget {
//   const NavigationBody({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final api = Api.of(context);
//
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Clickable(
//               child: const Icon(Icons.menu, color: Colors.white),
//               onTap: () {
//                 // api.sidebarVisibilityState.setState(
//                 //     api.sidebarVisibilityState.currentState ==
//                 //         SidebarVisibility.hidden
//                 //         ? SidebarVisibility.visible
//                 //         : SidebarVisibility.hidden);
//               }),
//           Expanded(
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                      Tooltip(
//                         message: "Go to marketplace",
//                         child: Clickable(
//                             onTap: () {
//                               launchUrl(Uri.parse("/marketplace"));
//                             },
//                             child: const MarketPlaceCTA())),
//
//                   const SizedBox(width: 20),
//                   Clickable(
//                     onTap: () => api.navigationPopupDialogControllerState
//                         .showDialog(NavigationPopupDialogs.user),
//                     child: Stack(
//                       children: [
//                         const Icon(Icons.person, color: Colors.white),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 border:
//                                 Border.all(color: Colors.white, width: 1),
//                                 shape: BoxShape.circle,
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MarketPlaceCTA extends StatefulWidget {
//   const MarketPlaceCTA({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<MarketPlaceCTA> createState() => _MarketPlaceCTAState();
// }
//
// class _MarketPlaceCTAState extends State<MarketPlaceCTA>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500))
//       ..addListener(() {
//         setState(() {});
//       })
//       ..repeat(reverse: true);
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
//     return Transform.scale(
//         scale: Tween<double>(begin: 1, end: 1.3).animate(_controller).value,
//         child: const Icon(Icons.shopping_bag, color: Colors.white));
//   }
// }
//
