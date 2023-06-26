// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:smartcare_web/reusable/session_list_creation.dart';
//
// import 'clickable_ripple.dart';
//
// class ProgramSessionsGenerator extends StatefulWidget {
//   const ProgramSessionsGenerator(
//       {Key? key,
//         required this.sessions,
//         this.timezoneOffset,
//         this.maxDuration})
//       : super(key: key);
//
//   final List<SessionDraft> sessions;
//   final double? timezoneOffset;
//   final int? maxDuration;
//
//   @override
//   State<ProgramSessionsGenerator> createState() =>
//       _ProgramSessionsGeneratorState();
// }
//
// class _ProgramSessionsGeneratorState extends State<ProgramSessionsGenerator> {
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: [
//         ...List.generate(widget.sessions.length, (index) {
//           final e = widget.sessions[index];
//           e.name = "Session ${index + 1}";
//
//           return SessionListProgramCreation(
//               draft: e,
//               sessions: widget.sessions,
//               maxDuration: widget.maxDuration,
//               timezoneOffset: widget.timezoneOffset,
//               onRefresh: () => setState(() {}),
//               onDeleteTap: () {
//                 setState(() {
//                   widget.sessions.remove(e);
//                 });
//               });
//         }),
//         ClickableRipple(
//             onTap: () {
//               setState(() {
//                 widget.sessions.add(SessionDraft());
//               });
//             },
//             child: SvgPicture.asset("assets/icons/add_item.svg", height: 275))
//       ],
//     );
//   }
// }
//
