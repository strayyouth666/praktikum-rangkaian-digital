// import 'package:flutter/material.dart';
// import 'package:smartcare_web/reusable/project_colors.dart';
//
// import 'custom_button.dart';
// import 'custom_datepicker_form_field.dart';
// import 'custom_dropdown.dart';
// import 'helpers.dart';
//
// class SessionListProgramCreation extends StatefulWidget {
//   const SessionListProgramCreation(
//       {Key? key,
//         required this.draft,
//         required this.timezoneOffset,
//         required this.onDeleteTap,
//         required this.sessions,
//         required this.onRefresh,
//         this.maxDuration})
//       : super(key: key);
//
//   final double? timezoneOffset;
//   final int? maxDuration;
//   final void Function() onDeleteTap, onRefresh;
//   final List<SessionDraft> sessions;
//
//   @override
//   State<SessionListProgramCreation> createState() =>
//       _SessionListProgramCreationState();
// }
//
// class _SessionListProgramCreationState
//     extends State<SessionListProgramCreation> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//         padding: const EdgeInsets.all(20),
//         width: 300,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: const Color(0xFFEEEEEE))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.draft.name,
//                 style: const TextStyle(
//                     color: ProjectColors.defaultBlack,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14)),
//             const SizedBox(height: 15),
//             CustomDatePickerFormField(
//                 validator: (value) {
//                   if (value!.millisecondsSinceEpoch <=
//                       DateTime.now().millisecondsSinceEpoch) {
//                     return "Start date must be more than today";
//                   }
//
//                   return null;
//                 },
//                 isExpanded: true,
//                 label: "Date",
//                 controller: widget.draft.dateController),
//             if (widget.draft.selectedTimeInterval > 0)
//               Center(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     Text(
//                         Helpers.timeToString(TimeOfDay.fromDateTime(
//                             DateTime.fromMillisecondsSinceEpoch(
//                                 (widget.draft.selectedTimeOffset - 60) *
//                                     60 *
//                                     1000)
//                                 .toUtc())) +
//                             " - " +
//                             Helpers.timeToString(TimeOfDay.fromDateTime(
//                                 DateTime.fromMillisecondsSinceEpoch(
//                                     widget.draft.selectedTimeInterval *
//                                         60 *
//                                         1000)
//                                     .toUtc())),
//                         style: const TextStyle(color: ProjectColors.lightBlack))
//                   ],
//                 ),
//               ),
//             const SizedBox(height: 10),
//             CustomDropdown(
//                 isExpanded: true,
//                 controller: widget.draft.coachController,
//                 items: coaches
//                     .map((e) =>
//                     DropdownMenuItem(child: Text(e.name), value: e.id))
//                     .toList(),
//                 hint: "Coach",
//                 hintAtTheTop: true),
//             const SizedBox(height: 10),
//             SelectTimeSlotDialog.durationDropdown(
//                 duration: widget.maxDuration ?? 3,
//                 controller: widget.draft.timeIntervalController),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                     child: CustomButton(
//                         value: "Select Time",
//                         onTap: () {
//                           if (widget.timezoneOffset == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     backgroundColor: ProjectColors.red,
//                                     content: Text(
//                                         "Please select the timezone first")));
//                             return;
//                           }
//
//                           Helpers.showModal(
//                               context: context,
//                               maxHeightAdjust:
//                               MediaQuery.of(context).size.height - 100,
//                               maxWidthAdjust:
//                               MediaQuery.of(context).size.width - 200,
//                               builder: (context) {
//                                 return SelectTimeSlotDialog(
//                                     onChanged: (_) {
//                                       widget.onRefresh();
//                                     },
//                                     bookedTimeslots: widget.sessions
//                                         .map((e) => TimeSlotModel()
//                                       ..startTime = e
//                                           .dateController.pickedDate!
//                                           .add(Duration(
//                                           minutes:
//                                           e.selectedTimeOffset -
//                                               60))
//                                       ..endTime = e
//                                           .dateController.pickedDate!
//                                           .add(Duration(
//                                           minutes:
//                                           e.selectedTimeInterval)))
//                                         .toList(),
//                                     timezoneOffset: widget.timezoneOffset,
//                                     sessionDraft: widget.draft);
//                               });
//                         })),
//                 const SizedBox(width: 10),
//                 Expanded(
//                     child: CustomButton(
//                         value: "Delete",
//                         onTap: widget.onDeleteTap,
//                         color: ProjectColors.red)),
//               ],
//             )
//           ],
//         ));
//   }
// }
